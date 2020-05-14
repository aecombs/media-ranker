class HomepagesController < ApplicationController
  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @pizzas = Pizza.all
    else
      @pizzas = Pizza.all
    end
  end
end
