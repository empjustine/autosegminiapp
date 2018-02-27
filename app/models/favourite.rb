class Favourite < ApplicationRecord
  belongs_to :task_relation
  belongs_to :user

  validates :task_relation, presence: true
  validates :user, presence: true

  validates_uniqueness_of :task_relation, scope: :user
end
