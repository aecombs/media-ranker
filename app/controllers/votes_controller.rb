class VotesController < ApplicationController
  before_action :require_login, only: [:create]

  def index
    if params[:user_id]
      @votes = Vote.where(user_id: params[:user_id])
    elsif params[:pizza_id]
      @votes = Vote.where(pizza_id: params[:pizza_id])
    else
      @votes = Vote.all
    end
  end

  def create
    if session[:user_id]
      @vote = Vote.new(user: User.find_by(id: params[:user_id]), pizza: Pizza.find_by(id: params[:pizza_id]))
      if @vote.is_unique?
        if @vote.save
          flash[:success] = "Successfully upvoted!"
          redirect_back fallback_location: pizza_path(@vote.pizza.id)
          # redirect_to pizza_path(@vote.pizza.id)
          return
        else
          flash[:error] = "Something went wrong..."
          redirect_back fallback_location: pizza_path(@vote.pizza.id)
          # redirect_to pizza_path(@vote.pizza.id)
          return
        end
      else
        flash[:error] = "You have already voted for this pizza"
        redirect_back fallback_location: pizza_path(@vote.pizza.id)
      end
    else
      flash[:error] = "You must be logged in to do that!"
      redirect_to login_path
    end
  end

  private

  def vote_params
    return params.require(:vote).permit(:pizza_id, :user_id)
  end
end
