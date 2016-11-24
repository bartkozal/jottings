class Stack < ApplicationRecord
  has_many :documents, dependent: :destroy
  has_many :collaborations, dependent: :destroy
  has_many :collaborators, source: :user, through: :collaborations
  belongs_to :owner, class_name: "User"

  def assign_to(user)
    self.owner = user
    self.collaborators << user
  end

  def owner?(user)
    user == owner
  end

  def has_collaborator?(user)
    collaborators.include?(user)
  end

  def has_collaborators?
    collaborators.size > 1
  end

  def to_s
    return "Untitled stack" unless name.present?
    name
  end

  def to_param
    MaskedId.encode(:stack, id)
  end
end
