class User < ApplicationRecord
  include Clearance::User

  has_many :stacks, through: :collaborations, dependent: :destroy
  has_many :collaborations, dependent: :destroy
  has_many :documents, through: :stacks
  has_many :bookmarks, dependent: :destroy
  has_one :root_stack, class_name: "Stack", dependent: :destroy

  after_create :assign_invited_collaborations, :create_root_stack

  def last_updated_document
    documents.last_updated
  end

  def bookmarked_documents
    bookmarks.includes(:document).map(&:document)
  end

  def bookmarked?(document)
    bookmarks.find_by(document: document).present?
  end

  def own_shared_stacks?
    stacks.joins(:collaborations).where(owner: self).group("stacks.id")
      .having("count(collaborations.share_id) > 1").present?
  end

  def to_s
    name || email
  end

  private

  def assign_invited_collaborations
    Collaboration.where(invite_email: email).update_all(user_id: id)
  end

  def create_root_stack
    stack = Stack.create
    stack.assign_to(user)
    self.root_stack = stack
  end
end
