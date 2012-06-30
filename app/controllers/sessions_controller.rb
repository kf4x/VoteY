class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user
      if params[:remember_me]
      cookies.permanent[:auth_token] = user.auth_token
      end
      cookies[:auth_token] = user.auth_token
      redirect_to root_url, :notice => "Logged in!"
    else
      flash[:notice] = "Invalid username or password"
      render "new"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url
    flash[:notice] = "Logged out!"
  end
end
