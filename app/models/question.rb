class Question < ApplicationRecord
  belongs_to :survey
  has_many :options, dependent: :destroy
  has_many :users, through: :options

  validates_presence_of :name
end
