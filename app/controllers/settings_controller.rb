class SettingsController < ApplicationController
  expose(:user)

  def update
    if user.update_attributes(params[:user]) 
      flash[:notice] = "successfully updated your information"      
      redirect_to settings_url
    else
      flash[:notice] = "error udpated your information"      
      redirect_to settings_url
    end
  end
  
  def reset_password
    flash[:notice] = "reset password success" ,setting_url if user.reset_password params[:user]
  end


  def forget_password
    
  end
end
