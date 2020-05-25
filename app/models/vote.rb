class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :pizza

  validates :pizza_id, presence: true, numericality: true
  validates :user_id, presence: true, numericality: true
end