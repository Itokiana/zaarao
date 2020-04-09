 class Space < ApplicationRecord
  scope :discoverables, lambda {where("discoverable")}

  after_create :add_logo_and_cover_picture
  
  belongs_to :admin, class_name: "User"
  has_and_belongs_to_many :members, class_name: "User"

  has_many :ideas       
  has_many :surveys     
  has_many :projects    
  has_many :actualities 

  has_one_attached :logo
  has_one_attached :cover_picture
	
	def add_logo_and_cover_picture
  	if !self.logo.attached?
      self.logo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-logo.png')), filename: 'default-logo.png', content_type: 'image/png')
  	end
  	if !self.cover_picture.attached?
      self.cover_picture.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-cover-picture.png')), filename: 'default-cover-picture.png', content_type: 'image/png')
  	end
  end

  def public?
    !private?
  end

  def vip?
    self.private?
  end

  def contributions
    c = []
    self.members.each do |user|
      c << user.ideas
      c << user.surveys
    end
    c
  end

  def discoverable?
    self.discoverable
  end

  def hidden?
    !discoverable?
  end

  def self.default
    Space.find_by(name: "C.U.A")
  end

  def ready_ideas
    self.ideas.where(ready: true)
  end

  def ready_projects
    self.projects.where(ready: true)
  end

  def ready_surveys
    self.surveys.where(ready: true)
  end

  def ready_actualities
    self.actualities.where(ready: true)
  end

  def all_items
    self.ideas + self.projects + self.actualities + self.surveys
  end

  def safe_link
    self.name.gsub('.','-')
  end

  def off_ideas
    self.ideas.select { |i| !i.on }
  end

  def on_ideas
    self.ideas.select { |i| i.on }
  end

  # searchkick
end
