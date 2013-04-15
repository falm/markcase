class Admin::UsersController < AdminController

  expose(:users) { User.paginate(page: params[:page])}
  expose(:user)
  expose(:categories) { user.categories }
  expose(:bookmarks) { user.bookmarks}
  expose(:bookmark) { user.bookmarks.build }
     
  def index
    #@users = User.paginate(page: params[:page]) 
    @users = users
    respond_to do |format|
      format.html  
      format.js { render layout: false }
    end
  end
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
    respond_to do |format|
      format.html {    
        redirect_to admin_users_url, notice: "Successfully Destroyed user" }
      format.json { render json: { :message => "user has been deleted"} }
    end
  end

  def get_bookmarks
    respond_to do |format|
      format.json { render json: bookmarks }
    end
  end

  def get_categories
    respond_to do |format|
      format.json { render json: categories}
    end
  end

end
