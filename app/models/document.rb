class Document < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :collaborations, dependent: :destroy
  has_many :collaborators, source: :user, through: :collaborations

  has_paper_trail on: [:create, :update], only: [:body]

  delegate :version_at, to: :paper_trail

  class << self
    def last_updated
      order(:updated_at).last
    end
  end

  def assign_to(user)
    self.owner = user
    self.collaborators << user
  end

  def owner?(user)
    user == owner
  end

  def has_collaborators?
    collaborators.size > 1
  end

  def title
    if body.present?
      body.lines.first.strip.remove(/\A\W+\s+/).truncate(24, separator: " ")
    else
      "Untitled"
    end
  end

  def changeset_since_last_seen(user)
    changeset = Document::Changeset.new
    changeset.document = self
    changeset.since_last_seen(user)
  end

  def to_s
    title
  end

  def to_param
    MaskedId.encode(id)
  end
end
