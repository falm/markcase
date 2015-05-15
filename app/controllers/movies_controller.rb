#encoding: utf-8
class MoviesController < ApplicationController

  MAX_ATTEMPTS = 2
  expose(:user) { User.find(current_user.id) }
  expose(:bookmarks) { user.bookmarks}
  expose(:movie)
  expose(:bookmark)


  def new


    respond_to do |format|
      format.js
    end
  end

  def create
    if movie.save
      respond_to do |format|
        format.html { redirect_to home_url, notice: 'successfully created bookmark'}
        format.json { render json: { message: "successfully created bookmark"}  }
      end
    else
      respond_to do |format|
        format.html {
          flash[:error] = "addtions bookmarks failed !"
          redirect_to home_url
        }
        format.json { render json: { message: "addtions bookmarks failed !"} }
      end
    end
  end


  def description
    require 'open-uri'
    url = params[:url]
    attempts = 0
    begin

      # doc = Nokogiri::HTML(open(url))
      # description = doc.xpath("//meta[@name='description']/@content").text
      description = Bookmark.get_movie_description url

    rescue => e
      attempts += 1
      retry if attempts <= MAX_ATTEMPTS
    end
    respond_to do |format|
      format.json { render json: {description: description} }
    end
  end

end
