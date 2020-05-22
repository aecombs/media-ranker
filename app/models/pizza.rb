class Pizza < ApplicationRecord
  has_many :votes

  validates :crust, presence: true
  validates :name, presence: true, uniqueness: true

  def self.get_top_ten(crust)
    pizzas_of_crust_type = Pizza.where(crust: crust)
    # if pizzas_of_crust_type.first.....has votes
    #   return pizzas_of_crust_type.order("votes DESC").limit(10)
    # else
      return pizzas_of_crust_type.order("id DESC").limit(10)
    # end
  end

  def self.get_spotlight
    #TODO: change id DESC to votes DESC
    top_ten_pizzas = Pizza.all.order("id DESC").limit(10)
    #TODO: randomly select of the top ten votes?
    return top_ten_pizzas.first
  end
end