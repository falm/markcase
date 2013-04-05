class ApplicationController < ActionController::Base
  protect_from_forgery
  def index
    
  end
  def current_user
    @current_user ||= session[:user] 
  end
  helper_method :current_user
end
