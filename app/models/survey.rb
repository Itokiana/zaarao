class Survey < ApplicationRecord
  after_create :add_cover_picture
  belongs_to :admin, class_name: "User"
  belongs_to :space
  has_many :questions, dependent: :destroy
  has_many :options, through: :questions
  has_many :users, through: :questions
  validates_presence_of :name, :end_date, :description

  belongs_to :type
  has_one_attached :cover_picture

  def finished?
  	self.end_date.past?
  end

  def ready?
  	self.questions.any? && self.ready
  end

  def add_cover_picture
    if !self.cover_picture.attached?
      self.cover_picture.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-cover-picture.png')), filename: 'default-cover-picture.png', content_type: 'image/png')
    end
  end

  def safe_users
    users = []
    self.users.each do |user|
      users << user if !users.include?(user)
    end
    return users
  end

  scope :search_import, -> { includes(:type) }

  def search_data
    {
      types: "#{name} #{type.name}"
    }
  end

  # searchkick
  acts_as_votable
  acts_as_commentable

  def comments
    self.comment_threads
  end
end
