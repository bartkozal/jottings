module Shareable
  extend ActiveSupport::Concern

  included do
    has_many :collaborations, dependent: :destroy, as: :share, inverse_of: :share
    has_many :collaborators, source: :user, through: :collaborations
    belongs_to :owner, class_name: "User"
  end

  def assign_to(user)
    self.owner = user
    self.collaborators << user
  end

  def owner?(user)
    user == owner
  end

  def collaborate?(user)
    collaborators.include?(user)
  end

  def has_collaborators?
    collaborators.size > 1
  end
end
