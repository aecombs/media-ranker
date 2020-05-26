class UsersController < ApplicationController
  before_action :require_login, only: [:current]
  before_action :find_user, only: [:login, :new]
  before_action :current_user, only: [:logout, :current]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      flash[:error] = "Unvalid User ID"
      redirect_to users_path
      return
    end
    @votes = @user.votes
    @pizzas = @votes.map { |v| v.pizza }
  end

  def login_form
    @user = User.new
  end

  def login
    if @user
      session[:user_id] = @user.id
      flash[:success] = "Welcome back, #{@user.username}!"
    else
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Welcome, #{@user.username}!"
      else
        flash.now[:error] = "Unable to log user in"
        render :login_form
        return
      end
    end
    redirect_to root_path
    return
  end

  def logout
    if session[:user_id]
      unless @user.nil?
        session[:user_id] = nil
        flash[:success] = "Logout successful -- see you later, #{@user.username}!"
        redirect_to root_path
        return
      else
        session[:user_id] = nil
        flash[:error] = "There was an error -- Unknown User"
      end
    else
      flash[:error] = "You must be logged in if you want to log out."
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
    return params.require(:user).permit(:username, votes: [])
  end

  def find_user
    @username = params[:user][:username]
    @user = User.find_by(username: @username)
  end
end
