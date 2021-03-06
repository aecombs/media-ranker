class Pizza < ApplicationRecord
  has_many :votes

  validates :crust, presence: true
  validates :name, presence: true, uniqueness: true

  def self.get_top(crust = nil)
    if crust
      pizzas = Pizza.where(crust: crust)
      return nil if pizzas.empty?
    else
      pizzas = Pizza.all
    end
    
    top_pizzas = pizzas.sort_by { |p| p.votes.length }
    return top_pizzas.reverse
  end

  def self.get_spotlight
    top = self.get_top
    return nil if top.nil?
    return top.first
  end
end