class Admin::SessionsController < AdminController
  skip_before_filter :login_required
  layout false
  def new
  end

  def create
    @admin = Administrator.authenticate(params[:username],params[:password])
    if @admin
      session[:admin] = @admin
      flash[:notice] = "Welcome  #{@admin.username}"
      redirect_to admin_users_url
    else
      flash[:error] = "The username or password are incorrect"
      redirect_to admin_login_url
    end
  end
  def destroy
    session[:admin] = nil
    redirect_to root_path
  end
end
