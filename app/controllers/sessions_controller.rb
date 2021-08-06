class SessionsController < ApplicationController
  def new
    render 'users/login'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    
    if user && user.authenticate(params[:session][:password]) 
      session[:user_id] = user.id.to_s
      redirect_to root_path
    else
      flash[:failure] = "Incorrect email or password, try again."
      render 'users/login', :layout => false
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:success] = "Logged out!"
    redirect_to login_path
  end
end
