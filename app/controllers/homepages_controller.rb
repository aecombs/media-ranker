class HomepagesController < ApplicationController
  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @pizzas = Pizza.all
      @spotlight = Pizza.get_spotlight
    else
      @pizzas = Pizza.all
      @spotlight = Pizza.get_spotlight
    end
  end
end
