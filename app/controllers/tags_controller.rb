class TagsController < ApplicationController
  expose(:user) { User.find(current_user.id)}
  expose(:bookmark) { Bookmark.find(params[:bookmark_id])}

  def index
    @tags = user.owned_tags.order(:id) 
    respond_to do |format|
      format.json { render json: @tags } 
    end
  end

  def show
    @bookmarks = Bookmark.tagged_with(params[:id]).paginate(page: params[:page]) 
    respond_to do |format| 
      format.js {render layout: false } 
    end
  end

  def update
    if user.tag(bookmark,with: params[:id],on: :tags) 
      respond_to do |format|
        format.json { render json: { taglist: bookmark.tags, message: "successfully updated bookmark"}}
      end
    else
      respond_to do |format|
        format.json { render json: { message: "failed udpated bookmark"} }
      end
    end
  end
end
