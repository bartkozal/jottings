class User < ApplicationRecord
  include Clearance::User
  has_many :collaborations, dependent: :destroy
  has_many :documents, through: :collaborations

  def last_updated_document
    documents.last_updated
  end
end
