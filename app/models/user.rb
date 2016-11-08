class User < ApplicationRecord
  include Clearance::User

  has_many :collaborations, dependent: :destroy
  has_many :documents, through: :collaborations, source: :share, source_type: "Document"
  has_many :stacks, through: :collaborations, source: :share, source_type: "Stack"
  has_many :bookmarks, dependent: :destroy

  after_create :assign_invited_collaborations

  def last_updated_document
    documents.last_updated
  end

  def bookmarked_documents
    bookmarks.includes(:document).order("documents.body").map(&:document)
  end

  def find_bookmark(document)
    bookmarks.find_by(document: document)
  end

  def bookmarked?(document)
    find_bookmark(document).present?
  end

  def own_shares?
    documents.joins(:collaborations).where(owner: self).group("documents.id")
      .having("count(collaborations.share_id) > 1").present? ||
    stacks.joins(:collaborations).where(owner: self).group("stacks.id")
      .having("count(collaborations.share_id) > 1").present?
  end

  def find_document_through_collaborations(param)
    self.documents.includes(:collaborators).find_by(id: param) ||
      self.stacks.joins(:documents).where("documents.id = ?", param).first
      &.documents&.includes(:collaborators)&.find(param)
  end

  def tree_view
    stacks = self.stacks.includes(:documents).order(:name, "documents.body")
    documents = self.documents.includes(:stack).order(:body)

    tree_view = TreeView.new(stacks: stacks, documents: documents)
    tree_view.arrange
  end

  def to_s
    name || email
  end

  private

  def assign_invited_collaborations
    Collaboration.where(invite_email: email).update_all(user_id: id)
  end
end
