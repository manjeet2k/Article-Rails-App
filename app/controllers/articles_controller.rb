class ArticlesController < ApplicationController
  before_action :require_user, except: [:index, :show]
  before_action :set_categories, except: [:show, :update, :destroy]

  def index  
    if params[:filter_option]
      return redirect_to articles_path if params[:filter_option] == ""
      @articles = Article.where(category_id: params[:filter_option])
      return
    elsif params[:search_name] 
      @articles = Article.where("name LIKE ?", "%#{params[:search_name].downcase}%")
      return
    end

    @articles = Article.all
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

  def download
    @articles = current_user.articles

    respond_to do |format|
      format.pdf do
        pdf = RandomName.new(current_user)
        send_data pdf.render,
          filename: "export.pdf",
          type: 'application/pdf',
          disposition: 'inline'
      end
    end
  end

  private
  
  def article_params
    params.require(:article).permit(:name, :description, :user_id, :category_id, :image)
  end

  def set_categories
    @categories = Category.all
  end
end