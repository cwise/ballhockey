# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery :except => [:lookup]
  before_filter :instantiate_controller_and_action_names

  def instantiate_controller_and_action_names
      @current_action = action_name
      @current_controller = controller_name
  end
  
  def admin?
    session[:password]=='playhockey'
  end
  helper_method :admin?

  def admin_required
    return true if admin?
    session[:return_to]=request.request_uri
    redirect_to login_path and
      return false
  end
  helper_method :admin_required
end
