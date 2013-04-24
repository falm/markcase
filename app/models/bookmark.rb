#encoding: utf-8
require 'open-uri'

class Bookmark < ActiveRecord::Base

  MAX_ATTEMPTS = ENV['MAX_ATTEMPTS']
  attr_accessible :category_id, :inbox, :link, :note, :star, :title, :user_id, :tag_list
  belongs_to :user
  belongs_to :category
  self.per_page =  ENV['PER_PAGE']
  acts_as_taggable_on :tags

  
  scope :favorite, lambda { where(star: true)}
  scope :show_inbox, lambda { where(inbox: true)}
  

  after_create :get_bookmark_title
  
  def tags
    tags_from(user) 
  end

  def change_star
    update_attribute(:star,!self.star) 
    save
  end
private 


  def get_bookmark_title
    url = "http://#{self.link}"    
    attempts = 0
    begin
      page = Nokogiri::HTML.parse(open(url))
      self.title = page.css('title').text
      self.save
    rescue Exception => e
      attempts = attempts + 1
      retry if attempts < MAX_ATTEMPTS 
    end
    if page.nil?
      self.title = "The URL is incorrect"
      self.save
    end
  end
end
