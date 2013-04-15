#encoding: utf-8
class UsersController < ApplicationController

  expose(:users)
  expose(:user) { User.find(current_user.id)}
  expose(:categories) { user.categories}
  expose(:bookmarks) { user.bookmarks.order("id desc").paginate(page: params[:page])}

  def index
  end

  def create
    @user = User.register(params)
    if @user  
      session[:user] = @user
      redirect_to home_path, notice: "注册成功！"
    else
      flash[:error] = "your email or password are incorrect relase try again"       
      redirect_to root_path    
    end

  end

  def update
    
    if user.update_attributes(params[:user]) 
      redirect_to settings_url, notice: "successfully updated your information"      
    else
      flash[:error] = "error udpated your information"      
      redirect_to settings_url
    end
  end

  def home
    get_bookmarks   
    @categories = categories
    @bookmarks = bookmarks.where(inbox: false)
    respond_to   do |format|
      format.html
      format.js { render layout: false } 
    end
  end
private 
  def get_bookmarks
    case params[:show_type]
      when 'inbox'
        @inbox_bookmarks = bookmarks.show_inbox 
      when 'favorite'
        @inbox_bookmarks = bookmarks.favorite
    end
  end
end
