#encoding: utf-8
require 'rubygems'

require 'nokogiri'

require 'open-uri'
require 'cgi'



keywords = CGI::escape ARGV[0] #"盗梦空间"

# url = "http://search.mtime.com/search/?q=#{keywords}"
# url = "https://www.baidu.com/s?wd=#{keywords}"
# url = "http://dianying.fm/category/key_#{keywords}?kw=#{keywords}"
# url = "http://movie.douban.com/subject_search?search_text=#{keywords}"
# url = "http://www.gewara.com/newSearchKey.xhtml?skey=#{keywords}&channel=movie"
# url = "http://www.1905.com/search/?q=#{keywords}"
url = "http://www.1905.com/search/index-p-type-film-q-#{keywords}.html"

uri_handler = open(url)

page = Nokogiri::HTML.parse(uri_handler)

# movie_url = page.css('a[pan="M14_SearchIndex_MoreResult_MovieTitle"]').attr('href').value
# movie_url = page.css('.c-img6').first().attr('src').value
movie_url = page.css("img[title='#{ARGV[0]}']").attr('src').value
# movie_url = page.css("img[alt='#{keywords}']").first().attr('src').value

movie_url.gsub!(/\/m\//,'/l/')

movie_url.gsub!(/\_[0-9]{3}\_[0-9]{3}\_/,'_200_300_')

puts movie_url 
#
# movie_uri = open(movie_url)
#
# doc = Nokogiri::HTML.parse(movie_uri)
#
# text = doc.css('span[property="v:summary"]').text
#
# score = doc.css('strong[property="v:average"]').text
#
# img_url = doc.css('img[rel="v:image"]').attr('src').text
#
# puts '== short desc =='
# puts text
#
# puts '== movies score =='
# puts score
#
# puts '== movies image url=='
# puts img_url
#
#
#
#

