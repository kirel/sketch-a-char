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
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end
  
  def admin?
    signed_in? && current_user.admin?
  end

  helper_method :current_user, :signed_in?, :admin?

  def login!(user)
    @current_user = user.tap { session[:user_id] = user.id }
  end
  
  def logout!
    nil.tap { session.delete :user_id }
  end
  
  def require_current_user
    redirect_to login_path unless signed_in?
  end
  
  def require_admin
    permission_denied unless admin?
  end
  
  def permission_denied
    render :file => "public/401.html", :status => :unauthorized
  end
  
  def cache!
    response.headers['Cache-Control'] = 'public, max-age=86400' # cache for a day
  end
  
end
