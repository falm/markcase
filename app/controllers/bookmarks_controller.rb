#encoding: utf-8
class BookmarksController < ApplicationController
  MAX_ATTEMPTS = 2
  expose(:user) { User.find(current_user.id) }
  expose(:bookmarks) { user.bookmarks} 
  expose(:bookmark)

  def index
    bookmarks.each do |bookmark|
      bookmark[:tag_list] = bookmark.tag_list
    end
    respond_to do |format|
      format.json { render json: bookmarks}
    end
  end

  def create
    if bookmark.save
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

  def update
    if user.tag(bookmark,with: params[:tags],on: :tags) 
      respond_to do |format|
        format.json { render json: { taglist: bookmark.tags, message: "successfully updated bookmark"}}
      end
    else
      respond_to do |format|
        format.json { render json: { message: "failed udpated bookmark"} }
      end
    end
  end


  def show
    case params[:id]
      when 'inbox'
        @bookmarks = bookmarks.show_inbox.paginate(page: params[:page])
        respond_to do |format|
          format.json { render json: bookmarks.show_inbox }
          format.js { render layout: false}
        end
      when 'favorite'
        @bookmarks = bookmarks.favorite.paginate(page: params[:page])
        respond_to do |format|
          format.json { render json: bookmarks.favorite }
          format.js { render layout: false}
        end
      when 'note'
        respond_to  do |format|
          format.json { render json: Bookmark.select(:note).find(params[:t_id]).to_json  } 
        end
    end
  end

  def tag
    @bookmarks = Bookmark.tagged_with(params[:tags]).paginate(page: params[:page]) 
    respond_to do |format| 
      format.js {render layout: false } 
    end
  end

  def tags
    @tags = user.owned_tags.order(:id)
    respond_to  do |format|
      format.json { render json: @tags}
    end
  end

  def description
    require 'open-uri'
    url = params[:url] 
    url = "http://#{url}"
    attempts = 0
    begin
      doc = Nokogiri::HTML(open(url)) 
      description = doc.xpath("//meta[@name='description']/@content").text
       
    rescue Exception => e
      attempts = attempts + 1
      retry if attempts <= MAX_ATTEMPTS 
    end
    respond_to do |format|
      format.json { render json: {description: description} }
    end
  end

  def destroy_multiple
    if params[:destroy_button]
      Bookmark.destroy(params[:id])
      redirect_to home_path, notice: "已删除选择的书签"
      return 
    end
    if params[:inbox_button]
      bookmark.each do |bo| 
        unless bo.update_attribute(:inbox,true)
          flash[:error] = "归档失败"
          redirect_to home_url
          return 
        end
      end
      redirect_to home_url, notice: "已归档"
    else
      bookmark.each do |bo|
        unless bo.update_attribute(:category_id, params[:category_id]) 
          flash[:error] = "移动失败"
          redirect_to home_url
          return 
        end
      end
      redirect_to home_url, notice: "移动成功!"
    end
  end

  def destroy
    bookmark.destroy
    respond_to do |format|
      format.json { head no_content}
    end
  end
end
