class User < ApplicationRecord
  include Clearance::User

  has_many :notes

  def gravatar(size: 45)
    hash = Digest::MD5.hexdigest(email.downcase)
    "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
  end
end
