class Pizza < ApplicationRecord
  has_many :votes

  validates :crust, presence: true
  validates :name, presence: true, uniqueness: true

  def self.get_top_ten(crust = nil)
    if crust
      pizzas = Pizza.where(crust: crust)
    else
      pizzas = Pizza.all
    end
    
    top_pizzas = pizzas.sort_by { |p| p.votes.length }
    return top_pizzas.reverse[0..9]
  end

  def self.get_spotlight
    return self.get_top_ten.first
  end
end