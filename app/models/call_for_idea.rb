class CallForIdea < ApplicationRecord
  after_create :add_cover_picture
  belongs_to :project
  belongs_to :type
  
  has_many :ratings

  has_one_attached :cover_picture
  has_many :ideas
  has_many :users, through: :ideas

  def add_cover_picture
  	if !self.cover_picture.attached?
      self.cover_picture.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-cover-picture.png')), filename: 'default-cover-picture.png', content_type: 'image/png')
  	end
  end

  def admin
    self.project.admin
  end

  acts_as_votable
end
