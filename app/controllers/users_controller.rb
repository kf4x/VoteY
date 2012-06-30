class UsersController < ApplicationController
  
    before_filter :current_user, :only => [:update, :edit, :destroy]
    

  def index
    @user = User.all
    @title = "Users"
  end
  
  def create
    @user = User.create(params[:user])
    if @user.save
      UserMailer.user_greet(@user).deliver
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, :notice => "Successfully created #{@user.username} and Logged in!"
    else
      render "new"
    end
  end
  
  def new
    @user = User.new
    @title = "New User"
  end
  
  def edit
    @user = current_user
    @title = "Edit " + current_user.username
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user #{@user.email}"
      redirect_to edit_user_path
    else
      render('new')
    end
  end
  
  def destroy
    @user = current_user
    flash[:notice] = "Successfully deleted user. Bye =()"
    cookies.delete(:auth_token)
    @user.destroy
    redirect_to root_path
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.username
  end
end