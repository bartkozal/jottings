# Preview all emails at http://localhost:3000/rails/mailers/collaboration_mailer
class CollaborationMailerPreview < ActionMailer::Preview
  def invite
    collaboration = Collaboration.new(
      invite_email: "invite@example.com",
      stack: Stack.new(
        name: "Drafts",
        owner: User.new(
          email: "john@example.com"
        )
      )
    )
    CollaborationMailer.invite(collaboration)
  end
end
