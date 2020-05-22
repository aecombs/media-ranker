class Pizza < ApplicationRecord
  has_many :votes

  validates :crust, presence: true
  validates :name, presence: true, uniqueness: true

  def self.get_top_ten(crust)
    pizzas_of_crust_type = Pizza.where(crust: crust).order("id DESC")
    return pizzas_of_crust_type.limit(10)
  end
end