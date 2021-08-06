class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  helper_method :current_user
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end


  private

    def logged_in_user
      unless logged_in?
        flash[:failure] = "Please log in."
        redirect_to login_url
      end
    end
end
