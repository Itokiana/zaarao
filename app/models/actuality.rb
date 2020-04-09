class Actuality < ApplicationRecord
	belongs_to :admin, class_name: "User"
  belongs_to :space
  has_many :users, through: :likes
  validates_presence_of :name
  validates_presence_of :description
  acts_as_votable
  acts_as_commentable
  
  # searchkick
end
