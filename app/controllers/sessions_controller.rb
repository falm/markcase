class SessionsController < ApplicationController

  def create
    @user = User.authenticate(params[:email],params[:password])
    if @user
      session[:user] = @user
      flash[:notice] = "Welcome  #{@admin.username}"
      redirect_to root_path
    else
      flash[:error] = "The username or password are incorrect"
      redirect_to root_path
    end
  end
  def destroy
    session[:user] = nil
    redirect_to root_path
  end

end
