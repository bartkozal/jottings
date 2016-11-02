class User < ApplicationRecord
  include Clearance::User

  has_many :collaborations, dependent: :destroy
  has_many :documents, through: :collaborations, source: :share, source_type: "Document"
  has_many :stacks, through: :collaborations, source: :share, source_type: "Stack"
  has_many :bookmarks, dependent: :destroy

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

  def own_shared_documents?
    documents.joins(:collaborations)
             .where(owner: self)
             .group("documents.id")
             .having("count(collaborations.share_id) > 1")
             .present?
  end

  def tree_view
    stacks = self.stacks.includes(:documents).order(:name, "documents.body")
    documents = self.documents.where(stack: nil).order(:body)

    tree_view = TreeView.new(stacks: stacks, documents: documents)
    tree_view.arrange
  end

  def to_s
    name || email
  end
end
