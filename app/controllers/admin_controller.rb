class AdminController < ApplicationController
  

  def index
    
  end

  def current_admin
    @current_admin ||= session[:admin]   
  end
  helper_method :current_admin
end
