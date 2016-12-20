# Preview all emails at http://localhost:3000/rails/mailers/feedback_mailer
class FeedbackMailerPreview < ActionMailer::Preview
  def notify
    feedback = Feedback.new(
      ip: "127.0.0.1",
      answers: {"apps": "1", "sync": "0", "editor": "1"},
      comment: "nice app!"
    )
    FeedbackMailer.notify(feedback)
  end
end
