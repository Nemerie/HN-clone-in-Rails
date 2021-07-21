class UsersController < ApplicationController
  def login
    render :layout => false
  end

  def create
    @user = User.new(user_params)
    
    # store all emails in lowercase to avoid duplicates and case-sensitive login errors:
    @user.email.downcase!
    
    if @user.save
      # If user saves in the db successfully:
      log_in @user
      flash[:notice] = "Account created successfully!"
      redirect_to root_path
    else
      # If user fails model validation - probably a bad password or duplicate email:
      flash.now.alert = "Couldn't create account."
      render :login
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
    # strong parameters - whitelist of allowed fields #=> permit(:name, :email, ...)
    # that can be submitted by a form to the user model #=> require(:user)
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
