class Pizza < ApplicationRecord
  has_many :votes

  validates :crust, presence: true
  validates :name, presence: true, uniqueness: true
end
