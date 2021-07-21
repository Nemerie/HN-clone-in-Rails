class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  # Make the current_user method available to views also, not just controllers:
  helper_method :current_user
  
  # Define the current_user method:
  def current_user
    # Look up the current user based on user_id in the session cookie:
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
