class PasswordResetsController < ApplicationController
  skip_before_filter :check_user

  def new
  end
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user 
    redirect_to root_path, notice: "确认邮件已经发送 请注意查收!"
  end  

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end  

  def update
    params[:user][:password] = params[:password]
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_send_at < 2.hours.ago
      flash[:error] = "重置密码确认链接超过2小时 失效 请重新填写信息发送!"
      redirect_to new_password_reset_path
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, notice: "密码已重置" 
    else
      render :edit
    end
  end
end
