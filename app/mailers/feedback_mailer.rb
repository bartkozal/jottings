class FeedbackMailer < ApplicationMailer
  def notify(feedback)
    @feedback = feedback

    mail to: "bkzl@me.com",
         subject: %(New feedback on Jottings)
  end
end
