class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!


  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  # def require_admin
  #   if !(logged_in? && current_user.admin?)
  #     flash[:alert] = "Only admins"
  #     redirect_to categories_path
  #   end
  # end
end
