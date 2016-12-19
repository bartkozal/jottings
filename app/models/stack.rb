class Stack < ApplicationRecord
  has_many :documents, dependent: :destroy
  has_many :collaborations, dependent: :destroy
  has_many :collaborators, source: :user, through: :collaborations
  belongs_to :owner, class_name: "User"
  belongs_to :user, inverse_of: :root_stack, optional: true

  default_scope { order(name: :asc) }

  accepts_nested_attributes_for :collaborations, reject_if: :all_blank

  acts_as_paranoid

  after_create :create_document, unless: -> { self.root? }

  class << self
    def without_root
      where(user: nil)
    end
  end

  def assign_to(user)
    self.owner = user
    self.collaborators << user
  end

  def root?
    user.present?
  end

  def owner?(user)
    user == owner
  end

  def has_collaborator?(user)
    collaborators.include?(user)
  end

  def has_collaborators?
    collaborators.size > 1
  end

  def to_s
    return "Untitled stack" unless name.present?
    name
  end

  def to_param
    MaskedId.encode(:stack, id)
  end

  private

  def create_document
    documents.create
  end
end
