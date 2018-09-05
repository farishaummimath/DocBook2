# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
   # See ActionController::RequestForgeryProtection for details
  helper_method :current_user
  protect_from_forgery
  before_filter { |c| Authorization.current_user = c.current_user }

  ## Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
   
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
   
  protected
  
  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access that page."
    redirect_to root_url
  end
  
  
end
