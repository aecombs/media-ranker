class VotesController < ApplicationController
  def index
  end

  def create

  end

  private

  def vote_params
    return params.require(:vote).permit(:pizza_id, :user_id)
  end
end
