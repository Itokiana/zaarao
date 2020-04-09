class Invitation < ApplicationRecord
	after_create :send_invitation_to_recipient
	
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  has_secure_token :password_token

  def send_invitation_to_recipient
  	InvitationMailer.send_invitation_to_recipient(self).deliver_now
  end

  def accepted?
    self.accepted
  end

  def declined?
    self.declined
  end

  def safe?
    !accepted? && !declined?
  end

  before_create :set_password_token

  private

  def set_password_token
    self.password_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless Invitation.where(password_token: token).exists?
    end
  end
end
