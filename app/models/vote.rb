class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :pizza

  validates :pizza_id, presence: true, numericality: true
  validates :user_id, presence: true, numericality: true

  def is_unique?
    #an array of all the votes from this user attempting to vote
    votes_by_user = Vote.where(user_id: self.user_id)
    
    votes_by_user.each do |vote|
      return false if vote.pizza_id == self.pizza_id
    end
    return true
  end
end