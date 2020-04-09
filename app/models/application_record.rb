class ApplicationRecord < ActiveRecord::Base
  extend Pagy::Search
  
  scope :contain?, lambda { |key| where("name like ?", "%#{key}%") }
  scope :ready?, lambda { where("ready") }

  require 'rails-timeago'
  include Rails.application.routes.url_helpers
  attr_accessor :current_user

  self.abstract_class = true

  def self.search(q)
    result = self.all.select do |e|
      e.name.include?(q) || e.description.include?(q) 
    end
    return result
  end

  def comments
    return self.comment_threads 
  end
  
  def viewers
    if self.class != CallForIdea
      attribute = self.class.to_s.downcase
      viewers = Viewer.where(wys_id: self.id, "#{attribute}": true)
    else
      viewers = Viewer.where(wys_id: self.id, call_for_idea: true)
    end
    return viewers
  end

  def positive_ratings
    self.get_likes
  end

  def negative_ratings
    self.get_dislikes
  end

  def likes
    self.get_likes
  end

  def html_description
  	self.description.html_safe
  end

  def ready_ideas
    self.ideas.where(ready: true)
  end

  def unready_ideas
  	self.ideas.where(ready: false)
  end

  def self.safe_all
    self.select { |e| e.id != self.first.id }
  end

  def males
    self.users.where(gender: "male")
  end

  def females
    self.users.where(gender: "female")
  end

  def kids
    self.users.select{|user| user.age < 15 }
  end

  def youngs
    self.users.select{|user| 15 <=  user.age && user.age < 35 }
  end

  def olds
    self.users.select{|user| 35 <=  user.age }
  end

  def failed
    print "XXX--- ERROR(S) ---XXX\n"
    self.errors.each do |error|
      print "~> " + error.to_s + "\n"
    end
    return false
  end

  def succeed
    print "O"
    return true
  end

  def to_safe_item
    self.class.to_s.downcase
  end

  def to_safe_items
    to_safe_item.pluralize
  end

  def space?
    self.class == Space
  end

  def idea?
    self.class == Idea
  end

  def project?
    self.class == Project
  end

  def survey?
    self.class == Survey
  end

  def actuality?
    self.class == Actuality
  end

  def call_for_idea?
    self.class == CallForIdea
  end

  def has_ratings?
    self.idea? || self.project? || self.call_for_idea?
  end

  def exist?
    !self.nil?
  end

  def feedbacks_length
    f = self.viewers.length
    if self.idea?
      f += self.ratings.length
      f += self.comments.length
    elsif self.actuality?
    elsif self.survey?
    else
      f += self.ratings.length
      f += self.ideas.length
    end
    return f
  end

  def has_image?
    self.file.content_type.to_s.downcase.include?"image"
  end

  def has_video?
    self.file.content_type.to_s.downcase.include?"video"
  end

  def content_file?
    self.description.include?("</video>") || self.description.include?("</audio>") || self.description.include?("<img")
  end

  def item_type
    self.class.to_s.underscore
  end
end
