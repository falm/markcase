class UsersController < ApplicationController
  expose(:users)
  expose(:user)
  def create
    @user = User.register(params[:user])
    if @user  
      session[:user] = @user
      flash[:notice] = "Login successful!"
      redirect_to home_path
    else
      flash[:notice] = "your email or password are incorrect relase try again"       
      redirect_to root_path    
    end

  end
  
  def home
    
  end
end
