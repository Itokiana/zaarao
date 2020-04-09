class Project < ApplicationRecord
	after_create :add_cover_picture
  belongs_to :admin, class_name: "User"
  belongs_to :space
  belongs_to :type
  has_many :call_for_ideas
  has_many :users, through: :call_for_ideas
  has_many :ideas, through: :call_for_ideas

  has_many :ratings

  has_one_attached :cover_picture

  def add_cover_picture
  	if !self.cover_picture.attached?
      self.cover_picture.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-cover-picture.png')), filename: 'default-cover-picture.png', content_type: 'image/png')
  	end
  end

  acts_as_votable
  scope :search_import, -> { includes(:type) }

  def search_data
    {
      types: "#{name} #{type.name}"
    }
  end
  
  # searchkick
  acts_as_commentable
end
