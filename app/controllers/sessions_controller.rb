class SessionsController < ApplicationController
  
  skip_before_filter :authorize
  
  def new
    if signed_in?
      redirect_to projects_url
    end
  end

  def signed_in?
    !session[:user_id].nil?
  end

  def create
  	user = User.find_by_username(params[:username])
  	if user and user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to projects_url
  	else
  		redirect_to login_url, alert: "Invalid user/password combination"
  	end
  end

  def destroy
  	session[:user_id] = nil
    redirect_to login_url, notice: "Logged out"
  end
end
