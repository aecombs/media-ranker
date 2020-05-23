class UsersController < ApplicationController

 before_action :find_user, only: [:show, :login, :new]
 before_action :find_session_user, only: [:logout, :current]

  def index
  end

  def show
    
  end

  def login_form
    @user = User.new
  end

  def login
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Welcome back, #{@user.username}!"
    else
      @user = User.create(username: @username)
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.username}!"
    end
    redirect_to root_path
    return
  end

  def logout
    if session[:user_id]
      unless @user.nil?
        session[:user_id] = nil
        flash[:notice] = "Logout successful -- see you later, #{@user.username}!"
        redirect_to root_path
        return
      else
        session[:user_id] = nil
        flash[:error] = "There was an error -- Unknown User"
      end
    else
      flash[:error] = "You must be logged in if you want to log out..."
    end
    redirect_to root_path
    return
  end

  def current
    if @user.nil?
      flash[:error] = "You must be logged in to view this page."
      redirect_to root_path
      return
    end
  end

  private

  def user_params
    #TODO: to include votes here for seeding data???
    return params.require(:users).permit(:username, votes: [])
  end

  def find_user
    @username = params[:user][:username]
    @user = User.find_by(username: @username)
  end

  def find_session_user
    @user = User.find_by(id: session[:user_id])
  end
end
