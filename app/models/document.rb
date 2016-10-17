class Document < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :collaborations, dependent: :destroy
  has_many :collaborators, source: :user, through: :collaborations

  def assign_to(user)
    self.owner = user
    self.collaborators << user
  end

  def owner?(user)
    user == owner
  end

  def title
    body.lines.first.strip
  end
end
