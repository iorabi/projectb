class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private
  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
  
  def signed_in?(user)
    return @current_user != nil
  end
  
  def sign_in(user)
    @current_user = user
    session[:session_token] = user.reset_token!
  end
  
  def sign_out
    current_user.reset_token!
    session[:session_token] = nil
  end
end
