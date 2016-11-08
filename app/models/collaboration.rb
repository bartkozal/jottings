class Collaboration < ApplicationRecord
  belongs_to :share, polymorphic: true
  belongs_to :user, optional: true

  validates :email, email: true, presence: true
  validates :user, uniqueness: { scope: [:share_type, :share_id], message: "already exists", allow_blank: true }
  validates :invite_email, uniqueness: { scope: [:share_type, :share_id], message: "already exists", allow_blank: true }

  def email
    invite_email || user&.email
  end

  def email=(email)
    email = normalize_email(email)
    if user = User.find_by(email: email)
      self.user = user
    else
      self.invite_email = email
    end
  end

  def invite?
    user.blank? && invite_email.present?
  end

  def type
    share_type.downcase.to_sym
  end

  def document?
    type == :document
  end

  def to_s
    user || invite_email
  end

  private

  def normalize_email(email)
    email.to_s.downcase.gsub(/\s+/, "")
  end
end
