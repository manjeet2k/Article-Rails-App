class OpinionsController < ApplicationController
  before_action :set_article
  before_action :require_user

  def like
    return redirect_to error_path if @article.user == current_user

    if user_opinion(@article).present?
      @opinion = user_opinion(@article).first
      @opinion.toggle!(:liked)
      @opinion.toggle!(:disliked) if @opinion.disliked?
      respond_to do |format|
        format.html
        format.js 
      end
    else
      @opinion = current_user.opinions.create(article_id: @article.id, liked: true)
      respond_to do |format|
        format.html
        format.js 
      end
    end
  end

  def dislike
    return redirect_to error_path if @article.user == current_user
    
    if user_opinion(@article).present?
      @opinion = user_opinion(@article).first
      @opinion.toggle!(:disliked)
      @opinion.toggle!(:liked) if @opinion.liked?
      respond_to do |format|
        format.html
        format.js 
      end
    else
      @opinion = current_user.opinions.create(article_id: @article.id, disliked: true)
      respond_to do |format|
        format.html
        format.js 
      end      
    end
  end

  private

  def set_article
    @article = Article.find params[:id]
  end
end
