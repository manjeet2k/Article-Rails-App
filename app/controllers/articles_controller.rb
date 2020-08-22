class ArticlesController < ApplicationController
  before_action :require_user, except: [:index, :show]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def create
    @article = Article.new(article_params)
    return redirect_to articles_path, flash: { success: ("Article was succesfully created!") } if @article.save  
    render 'new'
  end

  def show
    @article = Article.find params[:id]
  end

  def edit
    @article = Article.find(params[:id])
    @categories = Category.all

    return redirect_to error_path if @article.user != current_user
  end

  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      flash[:success] = "Article was succesfully Updated!"
      redirect_to articles_path
    else
      flash[:warning] = "#{article.errors.full_messages}"
      render 'edit'
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    flash[:danger] = " Article #{article.name} was deleted."
    redirect_to articles_path
  end

  private
  
  def article_params
    params.require(:article).permit(:name, :description, :user_id, :category_id, :image)
  end
end