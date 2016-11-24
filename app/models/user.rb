class User < ApplicationRecord
  include Clearance::User

  has_many :stacks, through: :collaborations
  has_many :collaborations, dependent: :destroy
  has_many :documents, through: :stacks
  has_many :bookmarks, dependent: :destroy

  after_create :assign_invited_collaborations

  def last_updated_document
    documents.last_updated
  end

  def bookmarked_documents
    bookmarks.includes(:document).order("documents.name").map(&:document)
  end

  def find_bookmark(document)
    bookmarks.find_by(document: document)
  end

  def bookmarked?(document)
    find_bookmark(document).present?
  end

  def own_shared_stacks?
    stacks.joins(:collaborations).where(owner: self).group("stacks.id")
      .having("count(collaborations.share_id) > 1").present?
  end

  def tree_view
    stacks = self.stacks.includes(:documents).order(:name, "documents.name")
    documents = self.documents.includes(:stack).order(:name)

    TreeView.new(stacks: stacks, documents: documents)
  end

  def to_s
    name || email
  end

  private

  def assign_invited_collaborations
    Collaboration.where(invite_email: email).update_all(user_id: id)
  end
end
