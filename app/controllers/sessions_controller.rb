class SessionsController < ApplicationController
  def new
  end
    
  def create
    session[:password]=params[:password]
    
    respond_to do |format|
      if admin?
        flash[:notice] = "Successfully logged in" 
        format.html { redirect_to session[:return_to] }  if session[:return_to]
        format.html { redirect_to root_path } unless session[:return_to]      
      else
        flash[:notice] = "Incorrect password" 
        format.html { redirect_to login_path }
      end
    end
  end

  def destroy
    reset_session
    
    respond_to do |format|
      flash[:notice] = "Successfully logged out"
      format.html { redirect_to root_path }
    end
  end
end