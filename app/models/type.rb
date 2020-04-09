class Type < ApplicationRecord
  has_many :surveys
  has_many :ideas
  has_many :projects
  has_many :call_for_ideas
end
