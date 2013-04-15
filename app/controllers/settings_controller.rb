class SettingsController < ApplicationController
  expose(:user) { User.find(current_user.id) }
=begin
  def update
    if user.update_attributes(params[:user]) 
      flash[:notice] = "successfully updated your information"      
      redirect_to settings_url
    else
      flash[:notice] = "error udpated your information"      
      redirect_to settings_url
    end
  end
=end
  def reset_password
    if user.reset_password params
      flash[:notice] = "reset password success" 
      redirect_to settings_url
    else
      flash[:error] = "reset password error:#{user.errors.full_messages.join}" 
      redirect_to settings_url
    end
  end


  def forget_password
    
  end
end
