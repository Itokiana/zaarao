class InvitationMailer < ApplicationMailer
	def send_invitation_to_recipient(invitation)
    @invitation = invitation
    @sender = @invitation.sender
    @recipient = @invitation.recipient
    @space = @sender.space
    @url = "http://zarao.co"

    mail(from: @sender.email, to: @recipient.email, subject: 'Invitation à rejoindre mon espace')
	end
end