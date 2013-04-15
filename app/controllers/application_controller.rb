#encoding: utf-8
class ApplicationController < ActionController::Base 
protect_from_forgery
  def index
    
  end
  def current_user
    @current_user ||= session[:user] 
  end
  helper_method :current_user
  before_filter :check_user, except: [:create]
  before_filter :make_action_mail_use_request_host, only: [:create]

protected

  def make_action_mail_use_request_host
    ActionMailer::Base.default_url_options[:host] = request.host    
  end

  def check_user
    return if controller_name == 'application'
    unless current_user 
      flash[:error] = '您还没有登录'    
      redirect_to root_url 
    end
  end
end
