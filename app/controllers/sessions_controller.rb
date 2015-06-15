#encoding: utf-8
class SessionsController < ApplicationController

  def create
    @user = User.authenticate(params[:email],params[:password])
    if @user
      session[:user] = @user
      flash[:notice] = "Welcome  #{@user.username}"
      redirect_to home_path
    else
      flash[:error] = '用户名和密码不正确'
      redirect_to root_path
    end
  end
  def destroy
    session[:user] = nil
    redirect_to root_path
  end

end
