class BookmarksController < ApplicationController

  expose(:user)
  expose(:bookmarks) { user.bookmarks} 
  expose(:bookmark)

  def index
    respond_to do |format|
      format.json { render json: bookmarks}
    end
  end

  def create
    @bookmark = user.bookmarks.build params[:bookmark] 
    if @bookmark
      respond_to do |format|
        format.json { render json: "successfully created bookmark"}
      end
    else
      respond_to do |format|
        format.json { render json: "addtions bookmarks failed !"}
      end
    end
  end

  def star
    if bookmark.star
      bookmark.off_star # scope :off_star, lambda { update_attribute(star: false)}
    else
      bookmmark.on_star # scope :on_star, lambda { udpate_attribute(star: true)}
    end
  end

  def show_inbox_or_favorite
    case params[:show_type]
      when 'inbox'
        respond_to do |format|
          format.json { render json: bookmark.where(inbox: true)}
        end
      when 'favorite'
        respond_to do |format|
          format.json { render json: bookmark.where(star: true)}
        end
    end
  end
  def destroy
    bookmark.destroy
    respond_to do |format|
      format.json { head no_content}
    end
  end
end
