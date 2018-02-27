require 'rails_helper'

RSpec.describe Favourite, type: :model do
  context 'invalid' do
    it 'has nothing' do
      expect(Favourite.new()).to_not be_valid
    end

    it 'lacks task_relation' do
      alice = create(:user)

      expect(Favourite.new(user: alice)).to_not be_valid
    end

    it 'lacks user' do
      alice = create(:user)

      task_relation = create(:task_relation, user: alice)
      expect(Favourite.new(task_relation: task_relation)).to_not be_valid
    end

    it 'has both task_relation and user, but task_relation is private' do
      alice = create(:user)
      bob = create(:user)

      task_relation = create(:task_relation, user: alice)
      expect(Favourite.new(task_relation: task_relation, user: bob)).to_not be_valid
    end
  end

  context 'valid' do
    it 'has both task_relation and user' do
      alice = create(:user)
      bob = create(:user)

      task_relation = create(:task_relation, user: alice, public: true)
      expect(Favourite.new(task_relation: task_relation, user: bob)).to be_valid
    end
  end

  context 'invalid' do
    it 'is a favourite duplicate' do
      alice = create(:user)
      bob = create(:user)

      task_relation = create(:task_relation, user: alice, public: true)
      old_favourite = Favourite.new(task_relation: task_relation, user: bob)
      old_favourite.save!
      expect(Favourite.new(task_relation: task_relation, user: bob)).to_not be_valid
    end

    it 'is a malicious third-party access attempt' do
      alice = create(:user)
      mallory = create(:user)

      task_relation = create(:task_relation, user: alice)
      expect(Favourite.new(task_relation: task_relation, user: mallory)).to_not be_valid
    end
  end
end