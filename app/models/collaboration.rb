class Collaboration < ApplicationRecord
  belongs_to :share, polymorphic: true
  belongs_to :user

  validates :user_email, email: true, presence: true

  def user_email
    user&.email
  end

  def user_email=(email)
    self.user = User.find_by(email: email)
  end
end
