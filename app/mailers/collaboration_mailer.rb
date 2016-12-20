class CollaborationMailer < ApplicationMailer
  def invite(collaboration)
    @collaboration = collaboration

    mail to: @collaboration.invite_email,
         subject: %(You are invited to collaborate on "#{@collaboration.stack}")
  end
end
