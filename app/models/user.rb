class User < ApplicationRecord
  include Clearance::User

  has_many :documents

  def gravatar(size: 90)
    hash = Digest::MD5.hexdigest(email.downcase)
    "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end
end
