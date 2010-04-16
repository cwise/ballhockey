# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :instantiate_controller_and_action_names, :adjust_format_for_iphone

  def instantiate_controller_and_action_names
      @current_action = action_name
      @current_controller = controller_name
  end

  def adjust_format_for_iphone
    request.format = :iphone if iphone_user_agent?
  end

  def iphone_user_agent?
    request.env["HTTP_USER_AGENT"] &&
      request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/]
  end
end
