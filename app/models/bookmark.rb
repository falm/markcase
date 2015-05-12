#encoding: utf-8
require 'open-uri'

class Bookmark < ActiveRecord::Base

  MAX_ATTEMPTS = ENV['MAX_ATTEMPTS'].to_i
  attr_accessible :category_id, :inbox, :link, :note, :star, :title, :user_id, :tag_list
  belongs_to :user
  belongs_to :category
  self.per_page =  ENV['PER_PAGE']
  acts_as_taggable_on :tags

  
  scope :favorite, lambda { where(star: true)}
  scope :show_inbox, lambda { where(inbox: true)}
  

  # after_create :get_bookmark_title
  after_create :get_movie_link

  def tags
    tags_from(user) 
  end

  def change_star
    update_attribute(:star,!self.star) 
    self.star
  end


  #
  # 通过url获取电影的简介
  #
  def self.get_movie_description(url)

    movie_uri = open(url)

    doc = Nokogiri::HTML.parse(movie_uri)

    text = doc.css('span[property="v:summary"]').text
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


  #
  # 获取电影的链接
  #
  def get_movie_link

    keywords = CGI::escape self.title

    url = "http://movie.douban.com/subject_search?search_text=#{keywords}"

    uri_handler = open(url)

    page = Nokogiri::HTML.parse(uri_handler)

    if page.blank?
      self.link = ''
      self.save
    end

    movie_url = page.css('.pl2').first.css('a').attr('href').value

    self.link = movie_url

    self.save

  end

  def get_movie_desc

    movie_uri = open(self.link)

    doc = Nokogiri::HTML.parse(movie_uri)

    text = doc.css('span[property="v:summary"]').text

  end


end
