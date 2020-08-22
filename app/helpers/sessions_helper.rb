module SessionsHelper
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    redirect_to login_path, flash: { danger: "You must log in to continue..." } unless logged_in?
  end

  def validate_admin
    redirect_to error_path unless logged_in? && current_user.admin?
  end

  def user_opinion(article)
    current_user.opinions.where(article_id: article.id)
  end
end