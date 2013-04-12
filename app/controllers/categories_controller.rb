class CategoriesController < ApplicationController
  expose(:user) { User.find(current_user.id)}
  expose(:categories) { user.categories}
  expose(:category)
  expose(:bookmarks) { category.bookmarks.paginate(page: params[:page])}

  def show
    @bookmarks = bookmarks
    respond_to  do |format|
      format.html
      format.js { render layout: false }
    end
  end
  def create
    if category.save 
      respond_to do |format|
        format.html { redirect_to home_url, notice: "收藏夹成功创建"}
        format.json  { render json: { message: "收藏夹成功创建"}}
      end
    else
      respond_to do |format|
        format.html {
          flash[:error] = "收藏夹创建失败"
          redirect_to home_url
        }
        format.json { render json: { message: "收藏夹创建失败"}}
      end
    end
  end
end
