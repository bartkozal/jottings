class Feedback < ApplicationRecord
  belongs_to :user, optional: true

  after_create :notify_by_email

  def to_s
    user.present? ? user.email : ip
  end

  private

  def notify_by_email
    FeedbackMailer.notify(self).deliver_later
  end
end
