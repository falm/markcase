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

  def new
    
  end

  def create
    if bookmark.save
      respond_to do |format|
        format.html { redirect_to home_url, notice: 'successfully created bookmark'}
        format.json { render json: { message: 'successfully created bookmark'}  }
      end
    else
      respond_to do |format|
        format.html { 
          flash[:error] = 'additions bookmarks failed !'
          redirect_to home_url
        }
        format.json { render json: { message: 'additions bookmarks failed !'} }
      end
    end
  end

  def update
    if bookmark.change_star 
      respond_to do |format|
        format.json { render json: { star: bookmark.star, message: 'successfully updated bookmark'}}
      end
    else
      respond_to do |format|
        format.json { render json: { message: 'failed updated bookmark'} }
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

  def description
    url = params[:url]
    title = params[:title]
    attempts = 0
    begin

      description = Bookmark.get_movie_description url
      image_url = Bookmark.get_movie_poster title

    rescue => e
      attempts += 1
      retry if attempts <= MAX_ATTEMPTS 
    end
    respond_to do |format|
      format.json { render json: {description: description, image_url: image_url} }
    end
  end

  def multiple
    if params[:destroy_button]
      Bookmark.destroy(params[:id])
      flash[:notice] = '已删除选择的书签'
    elsif params[:inbox_button]
      bookmark.each do |bo| 
        unless bo.update_attribute(:inbox,true)
          flash[:error] = '归档失败'
          redirect_to home_url and return
        end
      end
      flash[:notice] = '已归档'
    else
      bookmark.each do |bo|
        unless bo.update_attribute(:category_id, params[:category_id]) 
          flash[:error] = '移动失败'
          redirect_to home_url and return
        end
      end
      flash[:notice] = '移动成功!'
    end
    redirect_to home_url
  end

end
