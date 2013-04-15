#encoding: utf-8
class Admin::BookmarksController < AdminController
  
  expose(:bookmarks) { Bookmark.order("id desc").paginate(page: params[:page])}
  expose(:bookmark)
  expose(:bookmarks_with_tag) { Bookmark.tagged_with params[:tag] if params[:tag]}
    
  def index
    respond_to do |format|
      format.html  
      format.js { 
        @bookmarks = User.find(params[:user_id]).bookmarks.order("id desc").paginate(page: params[:page])
        render layout: false 
      }
    end
  end
  def create
    if bookmark.save 
      redirect_to admin_bookmarks_url, notice: "Successfully Created bookmark"
    else
      flash[:error] = "error Created user"
      redirect_to admin_users_url
    end 
  end

  def update
    if bookmark.update_attributes(params[:bookmark])  
      redirect_to admin_bookmark_url(bookmark), notice: "Successfully Updated bookmark"
    else
      flash[:error] = "error updated bookmark"
      redirect_to edit_bookmark_user_url
    end
  end

  def destroy
    bookmark.destroy
    redirect_to admin_bookmarks_url, notice: "Successfully Destroyed bookmark"

  end

  def tag
    if bookmark.user.tag(bookmark,with: params[:tags],on: :tags)
      respond_to do |format|
        format.json { render json: { message: 'success'}}
      end
    else
      respond_to do |format|
        format.json { render json: { message: 'failed'}}
      end
    end
  end
end
