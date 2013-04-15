#encoding: utf-8
class Admin::CategoriesController < AdminController
  expose(:user)
  expose(:categories) { user.categories} 
  expose(:category)
  expose(:bookmarks) { category.bookmarks.order(:id)}

  def index
    respond_to do |format|
      format.html
      format.js {
        @categories = categories.order(:id).paginate(page: params[:page])
        render layout: false
      }
    end
  end

  def create
    if category.save
      redirect_to admin_users_path, notice: "success created Category"
    else
      flash[:error] = "error created Category"
      redirect_to admin_users_path
    end
  end

  def destroy
    category.destroy
    redirect_to admin_users_path, notice: "successfully destoryed category"
  end

end
