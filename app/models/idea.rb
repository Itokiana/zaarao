class Idea < ApplicationRecord
	after_create :add_cover_picture
  mount_uploader :file, FileUploader
  
  belongs_to :admin, class_name: "User"
  belongs_to :space
  belongs_to :type
  belongs_to :call_for_idea, optional: true
  
  has_many :ratings

  has_one_attached :cover_picture
	
	def add_cover_picture
  	if !self.cover_picture.attached? 
      self.cover_picture.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-cover-picture.png')), filename: 'default-cover-picture.png', content_type: 'image/png')
  	end
  end

  def ready?
  	self.ready
  end

  def users
    u = []
    self.ratings.each do |rating|
      u << rating.user
    end
    u
  end

  def has_one_call_for_idea?
    !self.call_for_idea_id.nil?
  end

  acts_as_votable
  acts_as_commentable
  
  scope :search_import, -> { includes(:type) }

  def search_data
    {
      types: "#{name} #{type.name}"
    }
  end
  # searchkick
end
