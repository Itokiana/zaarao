class User < ApplicationRecord
	after_create :add_space, :add_avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :lockable, :timeoutable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  belongs_to :language

  has_one :created_space, class_name: "Space", foreign_key: :admin_id
  has_and_belongs_to_many :visited_spaces, class_name: "Space"
  
  has_many :actualities, foreign_key: :admin_id
  has_many :surveys, foreign_key: :admin_id
  has_many :ideas, foreign_key: :admin_id
  has_many :projects, foreign_key: :admin_id

  has_and_belongs_to_many :options

  has_one_attached :avatar

  has_many :ratings
  has_many :comments

  has_many :call_for_ideas, through: :projects

  has_and_belongs_to_many :activities
  has_many :viewers

  has_many :sent_invitations, class_name: "Invitation", foreign_key: "sender_id"
  has_many :received_invitations, class_name: "Invitation", foreign_key: "recipient_id"

	def likes?(actuality)
	 actuality.likes.where(user_id: id).any?
	end

  def add_space
    if !self.nil? && self.persisted? && !self.visited_spaces.any?
      if !self.admin? && !self.super_admin?
        self.visited_spaces.push(Space.first)
      end
    end
  end

  def add_avatar
  	if !self.nil? && !self.avatar.attached?
      self.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-user-avatar-1.png')), filename: 'default-user-avatar-1.png', content_type: 'image/png')
  	end
  end

  def citizen?
    self.role=="citizen"
  end

  def admin?
    self.admin
  end

  def super_admin?
    self.super_admin
  end

  def is_admin?
    (self.admin? && self.main_space == self.space) || self.super_admin?
  end

  def is_not_admin?
    !is_admin?
  end

  def has_fullname?
    if self.fullname && self.fullname != " "
      return true
    else
      return false
    end
  end

  def fullname
    self.firstname + " " + self.lastname
  end

  def age
    now = DateTime.now
    age = (now.to_i - birthdate.to_i)/(3600*24*365)
    return age
  end

  def main_activity
    activity = self.activities.first
    activity ||= Activity.last
    activity
  end

  def complete?
    !(self.uncomplete?)
  end

  def uncomplete?
    if !self.visited_spaces.any? || self.firstname.nil? || self.lastname.nil? || self.language.nil? || self.birthdate.nil? || self.address.nil? || !self.activities.any?
      return true
    else
      return false
    end
  end

  def space
    Space.find_by(admin: self)
  end

  def main_space
    if self.has_one_space?
      self.visited_spaces.first
    else
      Space.default
    end
  end

  def main_space_id
    main_space.id
  end

  def set_main_space(space_id)
    space = Space.find(space_id)
    if space
      self.visited_spaces = [space]
    end
    return true
  end

  def has_one_space?
    self.visited_spaces.any?
  end

	def rates(idea)
		self.ideas.include?(idea)
	end

  def answers
    self.options
  end

  def self.new_with_session(params, session)
   	super.tap do |user|
     	if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
       	user.email = data["email"] if user.email.blank?
     	end
   	end
 	end

 	def self.from_omniauth(auth)
   	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     	user.email = auth.info.email
      user.password = "123456"
     	user.password_confirmation = "123456"
      user.skip_confirmation!
   	end
 	end

 	def viewed(item)
 		if self.projects.include?(item) || self.ideas.include?(item) || self.surveys.include?(item) || self.call_for_ideas.include?(item) || self.actualities.include?(item)
 			return true
 		else
 			return false
 		end
 	end

  def rated(item)
    attribute = item.to_safe_item
    rating = Rating.find_by(wyr_id: item.id, "#{attribute}": true, user_id: self.id)
    return item.ratings.include?(rating)
  end

  def unread_invitations
    self.received_invitations.select { |invitation| invitation.safe? }
  end

  def has_unread_invitations?
    unread_invitations.any?
  end

  def last_invitation
    unread_invitations.last
  end

  def man?
    self.gender == "male"
  end

  def woman?
    self.gender == "female"
  end
end
