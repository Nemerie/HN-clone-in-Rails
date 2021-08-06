class UsersController < ApplicationController
  def login
    render :layout => false
  end

  def create
    @user = User.new(user_params)
    
    @user.email.downcase!
    
    if @user.save
      log_in @user
      flash[:success] = "Account created successfully!"
      redirect_to root_path
    else
      flash[:failure] = "Couldn't create account."
      render :login, :layout => false
    end
  end

  def show
    if current_user.nil?
      redirect_to login_path
    end

    @user = current_user
  end

private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
