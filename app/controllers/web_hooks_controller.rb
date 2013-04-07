class WebHooksController < ApplicationController
  def sendgrid_notify
    Resque.enqueue(SendgridNotifier, params)
    
    respond_to do |format|
      format.html  { render :nothing => true, :status => 200 }
    end
  end
end
