require 'rails_helper'

RSpec.describe TaskRelation, type: :model do
  context 'invalid' do
    it 'has no User' do
      expect(TaskRelation.new).to_not be_valid
    end
  end

  context 'valid' do
    it 'has User and no child Task' do
      task_relation = TaskRelation.new
      task_relation.user = create(:user)
      expect(task_relation).to be_valid
    end

    it 'has User and single child Task' do
      task_relation = TaskRelation.new
      task_relation.user = create(:user)
      task_relation.tasks.build({ description: "a task" })
      expect(task_relation).to be_valid
    end

    it 'has User and several children Tasks' do
      task_relation = TaskRelation.new
      task_relation.user = create(:user)
      10.times do ||
        task = create(:task, task_relation: task_relation)
        task_relation.tasks << task
      end
      expect(task_relation).to be_valid
    end
  end

  context 'valid and visible' do
    it 'is visible if User is the creator' do
      alice = create(:user)

      task_relation = TaskRelation.new
      task_relation.user = alice
      expect(task_relation.visible_to(alice)).to be_truthy
    end

    it 'is visible if public' do
      alice = create(:user)
      bob = create(:user)

      task_relation = TaskRelation.new
      task_relation.user = alice
      task_relation.public = true
      expect(task_relation.visible_to(bob)).to be_truthy
    end
  end

  context 'valid and not visible' do
    it "is hidden when isn't public and User isn't the creator" do
      alice = create(:user)
      mallory = create(:user)

      task_relation = TaskRelation.new
      task_relation.user = alice
      task_relation.public = false
      expect(task_relation.visible_to(mallory)).to be_falsey
    end
  end
end
