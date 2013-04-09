class UsersController < ApplicationController
  expose(:users)
  expose(:user) { User.find(current_user.id)}
  expose(:categories) { user.categories}
  expose(:bookmarks) { user.bookmarks}

  def create
    @user = User.register(params)
    if @user  
      session[:user] = @user
      redirect_to home_path, notice: "register successful!"
    else
      flash[:error] = "your email or password are incorrect relase try again"       
      redirect_to root_path    
    end

  end

  def update
    if user.update_attributes(params[:user]) 
      redirect_to settings_url, notice: "successfully updated your information"      
    else
      flash[:error] = "error udpated your information"      
      redirect_to settings_url
    end
  end
  
  def home
    
  end
end
