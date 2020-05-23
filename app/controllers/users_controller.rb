class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{username}!"
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{username}!"
    end
    redirect_to root_path
    return
  end

  def logout
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      unless user.nil?
        session[:user_id] = nil
        flash[:notice] = "Logout successful -- see you later, #{user.username}!"
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
  end
end
