class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  # def login
  #   user = User.find_by(username: params[:user][:username])

  #   if user.nil?
  #     #create new user
  #     user = User.new(username: params[:user][:username])
  #     if !user.save
  #       flash[:error] = "Unable to login"
  #       redirect_to root_path
  #       return
  #     end
  #     flash[:success] = "Welcome back, #{user.username}!"
  #   else
  #     flash[:success] = "Successfully logged in as #{user.username}."
  #   end
  #   session[:user_id] = user.id
  #   redirect_to root_path
  # end

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
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out."
    redirect_to root_path
    return
  end

  def current
  end
end
