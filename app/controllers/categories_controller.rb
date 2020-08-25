class CategoriesController < ApplicationController
  before_action :validate_admin
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(cat_params)
    if @category.save
      flash[:success] = "Category Added"
      redirect_to categories_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @category.update(cat_params)
      flash[:success] = "Category was succesfully Updated!"
      redirect_to categories_path
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:danger] = " Category #{@category.name} was deleted."
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
  
  def cat_params
    params.require(:category).permit(:name)
  end
end