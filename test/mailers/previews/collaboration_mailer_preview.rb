# Preview all emails at http://localhost:3000/rails/mailers/collaboration_mailer
class CollaborationMailerPreview < ActionMailer::Preview
  def invite
    CollaborationMailer.invite
  end

  def notify
    CollaborationMailer.notify
  end
end
