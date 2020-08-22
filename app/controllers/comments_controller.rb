class CommentsController < ApplicationController
  
  def create
    comment = Comment.new comment_params

    if comment.save
      redirect_to article_path(params[:comment][:article_id])
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :article_id, :comment)
  end
end
