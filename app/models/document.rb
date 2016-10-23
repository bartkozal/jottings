class Document < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :collaborations, dependent: :destroy
  has_many :collaborators, source: :user, through: :collaborations

  has_paper_trail on: [:create, :update], only: [:body]

  class << self
    def last_updated
      order(:created_at).last
    end
  end

  def assign_to(user)
    self.owner = user
    self.collaborators << user
  end

  def owner?(user)
    user == owner
  end

  def title
    body.lines.first.strip.remove(/\A\W+\s+/)
  end

  def to_s
    title
  end

  def to_param
    MaskedId.encode(id)
  end
end
