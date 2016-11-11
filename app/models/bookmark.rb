class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :document

  validates :user, uniqueness: { scope: [:document_id] }
end
