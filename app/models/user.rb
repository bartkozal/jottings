class User < ApplicationRecord
  include Clearance::User

  has_many :collaborations
  has_many :documents, through: :collaborations

  def gravatar(size: 90)
    hash = Digest::MD5.hexdigest(email.downcase)
    "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end
end
