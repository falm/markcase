#encoding: utf-8

class Movie < ActiveRecord::Base

  belongs_to :user

  attr_accessible :title, :id, :score, :short_desc, :recommend_words, :cover_url, :url, :user_id


  after_create :complete_movies_info


  def complete_movies_info

    movie_uri = open(self.url)

    doc = Nokogiri::HTML.parse(movie_uri)

    return if doc.blank?

    self.short_desc = doc.css('span[property="v:summary"]').text

    self.score = doc.css('strong[property="v:average"]').text

    self.cover_url = get_movie_poster self.title

    self.save!

  end


  def get_movie_poster(key)

    encode_key = CGI::escape key

    url = "http://www.1905.com/search/index-p-type-film-q-#{encode_key}.html"

    page = Nokogiri::HTML(open(url))

    image_url = page.css("img[title='#{key}']").attr('src').value

    image_url.gsub(/\_[0-9]{3}\_[0-9]{3}\_/,'_200_300_')

  end

end