class CollaborationMailer < ApplicationMailer
  def invite(collaboration)
    @collaboration = collaboration

    mail to: @collaboration.invite_email,
         subject: %(#{@collaboration.stack.owner} invited you to work on Markdown documents with Jottings)
  end
end
