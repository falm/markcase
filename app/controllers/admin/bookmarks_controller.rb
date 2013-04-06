class Admin::BookmarksController < AdminController
  
  expose(:bookmarks)
  expose(:bookmark)
  expose(:bookmarks_with_tag) { Bookmark.tagged_with params[:tag], any: true if params[:tag]}
    
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
  end
end
