class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
  end

  def logout
  end

  def current
  end
end
