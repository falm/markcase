#encoding: utf-8
class AdminController < ApplicationController
  

  def index
    
  end
  before_filter :login_required

  def current_admin
    @current_admin ||= session[:admin]   
  end

  helper_method :current_admin
  def login_required
    return if controller_name == 'admin' 
    redirect_to admin_login_url unless current_admin
  end
end
