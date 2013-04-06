class Admin::CategoriesController < ApplicationController
  expose(:user)
  expose(:categories) { user.categories} 
  expose(:category)

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
