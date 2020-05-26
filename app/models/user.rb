class User < ApplicationRecord
  has_many :votes

  validates :username, presence: true, length: { in: 2..15 }, format: { with: /[0-9A-Za-z]/, message: "must be only numbers and letters" }, uniqueness: true
end