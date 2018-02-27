class Task < ApplicationRecord
  belongs_to :task_relation

  validates :task_relation, presence: true
  validates :description, exclusion: { in: [nil] }

  def visible_to(user)
    self.task_relation.visible_to(user)
  end

  def close!(user)
    self.closed = true if self.task_relation.user == user
    self.save!
  end
end
