class User < ApplicationRecord
  has_secure_password

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      flash[:success] = "Signed up successfully!"
      session[:user_id] = user.id
      redirect_to root_path
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :admin)
  end
end
