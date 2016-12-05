class Document < ApplicationRecord
  belongs_to :stack
  has_many :bookmarks

  default_scope { order(name: :desc) }

  delegate :collaborators, to: :stack

  class << self
    def last_updated
      order(:updated_at).last
    end
  end

  def can_move?(user)
    stack.owner?(user)
  end

  def has_shared_stack?
    stack.has_collaborators?
  end

  def to_s
    name.presence || "Untitled document"
  end

  def to_param
    MaskedId.encode(:document, id)
  end
end
