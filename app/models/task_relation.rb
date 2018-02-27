class TaskRelation < ApplicationRecord

  belongs_to :user
  validates :user, presence: true

  has_many :tasks

  has_many :favourites
  has_many :users, through: :favourites

  # TODO: "correct" way to do nesting, figure out later
  # accepts_nested_attributes_for :tasks

  def self.all_owned(user)
    where("user_id = :user_id", { user_id: user.id })
  end

  def self.all_visible(user)
    left_joins(:favourites).where(
      "task_relations.user_id = :user_id OR task_relations.public = :public OR favourites.user_id = :user_id",
      { user_id: user.id, public: true },
    )
  end

  def self.all_favourites(user)
    left_joins(:favourites).where(
      "favourites.user_id = :user_id",
      { user_id: user.id },
    )
  end

  def visible_to(user)
    public = self.public
    owner = self.user == user
    favourite = Favourite.find_by({
      user: user,
      task_relation: self,
    })

    public || owner || favourite
  end

  def favourite!(user)
    self.users << user if self.public
    self.save! if self.valid?
  end
end
