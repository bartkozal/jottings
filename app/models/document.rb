class Document < ApplicationRecord
  belongs_to :stack
  has_many :bookmarks

  default_scope { order(name: :desc) }

  delegate :collaborators, to: :stack

  has_paper_trail on: [:create, :update], only: [:body]
  delegate :version_at, to: :paper_trail

  class << self
    def last_updated
      order(:updated_at).last
    end
  end

  def has_shared_stack?
    stack.has_collaborators?
  end

  def changeset_since_last_seen(user)
    changeset = Document::Changeset.new
    changeset.document = self
    changeset.since_last_seen(user)
  end

  def to_s
    name.presence || "Untitled document"
  end

  def to_param
    MaskedId.encode(:document, id)
  end
end
