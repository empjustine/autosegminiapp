require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'invalid' do
    it 'has no TaskRelation parent' do
      expect(Task.new).to_not be_valid
    end

    it 'has NULL description' do
      task = Task.new
      task.task_relation = create(:task_relation, user: create(:user))
      expect(task).to_not be_valid
    end
  end

  context 'valid' do
    it 'has a TaskRelation parent and a String description' do
      task = Task.new(description: "amaze")
      task.task_relation = create(:task_relation, user: create(:user))
      expect(task).to be_valid
    end
  end

  context 'valid and visible' do
    it 'is visible when user owns parent TaskRelation' do
      alice = create(:user)

      task = Task.new(description: "excite")
      task.task_relation = create(:task_relation, user: alice, public: true)
      expect(task.visible_to(alice)).to be_truthy
    end

    it 'is visible if parent TaskRelation is public' do
      alice = create(:user)
      bob = create(:user)

      task = Task.new(description: "very description")
      task.task_relation = create(:task_relation, user: alice, public: true)
      expect(task.visible_to(bob)).to be_truthy
    end
  end

  context 'valid and invisible' do
    it "shouldn't be visible if User isn't the creator of parent and parent isn't public" do
      alice = create(:user)
      mallory = create(:user)

      task = Task.new(description: "wow")
      task.task_relation = create(:task_relation, user: alice, public: false)
      expect(task.visible_to(mallory)).to be_falsey
    end
  end
end
