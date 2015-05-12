#encoding: utf-8
require 'rubygems'

require 'nokogiri'

require 'open-uri'
require 'cgi'



keywords = CGI::escape ARGV[0] #"盗梦空间"

#url = "http://search.mtime.com/search/?q=#{keywords}"
url = "http://movie.douban.com/subject_search?search_text=#{keywords}"

uri_handler = open(url)

page = Nokogiri::HTML.parse(uri_handler)

movie_url = page.css('.pl2').first.css('a').attr('href').value

puts movie_url 

movie_uri = open(movie_url)

doc = Nokogiri::HTML.parse(movie_uri)

text = doc.css('span[property="v:summary"]').text

score = doc.css('strong[property="v:average"]').text

img_url = doc.css('img[rel="v:image"]').attr('src').text

puts '== short desc =='
puts text

puts '== movies score =='
puts score

puts '== movies image url=='
puts img_url





