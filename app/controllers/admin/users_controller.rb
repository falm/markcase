class Admin::UsersController < AdminController
  expose(:users)
  expose(:user)
  expose(:categories) { user.categories }
  expose(:bookmarks) { user.bookmarks}
  expose(:bookmark) { user.bookmarks.build }
  
  def create
    if user.save 
      redirect_to admin_users_url, notice: "Successfully Created user"
    else
      flash[:error] = "error Created user"
      redirect_to admin_users_url
    end 
  end

  def update
    if user.update_attributes(params[:user])  
      redirect_to admin_user_url(user), notice: "Successfully Updated user"
    else
      flash[:error] = "error updated user"
      redirect_to edit_admin_user_url
    end
  end

  def destroy
    user.destroy
    redirect_to admin_users_url, notice: "Successfully Destroyed user"

  end
end
