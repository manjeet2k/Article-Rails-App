class ArticlesController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :set_categories, except: [:show, :update, :destroy]

  def index
    @articles = Article.all
  
    if params[:filter_option]
      return redirect_to articles_path if params[:filter_option] == ""
      @category = Category.find params[:filter_option]
      @articles = Article.where(category_id: @category.id)
    elsif params[:search_name] 
      @articles = Article.where("name LIKE ?", "%#{params[:search_name]}%")
    end
  end

  def new
    @article = Article.new
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

    return redirect_to error_path if @article.user != current_user
  end

  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      flash[:success] = "Article was succesfully Updated!"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    flash[:danger] = " Article #{article.name} was deleted."
    redirect_to articles_path
  end

  def liked_articles
    @articles = current_user.opinions.where(liked: true).collect { |opinion| opinion.article }
    render "index"
  end

  def commented_articles
    @articles = current_user.comments.distinct.pluck(:article_id).collect { |article| Article.find(article) }
    render "index"
  end

  def category_filters
    render "index"
  end

  def search
    render "index"
  end

  private
  
  def article_params
    params.require(:article).permit(:name, :description, :user_id, :category_id, :image)
  end

  def set_categories
    @categories = Category.all
  end
end