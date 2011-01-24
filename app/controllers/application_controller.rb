class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate
  protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "foo" && password == "bar"
    end if Rails.env.production?
  end
  
  def current_user
    # dev user if not in production
    return @current_user = User.find_or_create_by_name('dev user') if Rails.env.development?
    # normal user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  helper_method :current_user, :signed_in?

  def current_user=(user)
    @current_user = user.tap { session[:user_id] = user.id }
  end
end
