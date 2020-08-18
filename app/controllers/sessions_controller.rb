class SessionsController < ApplicationController
  
  def new
    return redirect_to root_path, flash: { warning: "You are already logged in..." } if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
      
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in!"
      redirect_to root_path
    else
      flash[:danger] = "Something Wrong in your login credentials!"
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    flash[:success] = "Logged out succesfully!"
    redirect_to root_path
  end
end
