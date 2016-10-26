class User < ApplicationRecord
  include Clearance::User
  has_many :collaborations, dependent: :destroy
  has_many :documents, through: :collaborations
  has_many :bookmarks, dependent: :destroy

  def last_updated_document
    documents.last_updated
  end

  def bookmarked_documents
    bookmarks.map(&:document)
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
             .having("count(collaborations.document_id) > 1")
             .present?
  end

  def to_s
    name || email
  end
end
