require "faker"
require "csv"

# we already provide a filled out works_seeds.csv file, but feel free to
# run this script in order to replace it and generate a new one
# run using the command:
# $ ruby db/generate_seeds.rb
# if satisfied with this new works_seeds.csv file, recreate the db with:
# $ rails db:reset
# doesn't currently check for if titles are unique against each other

CSV.open("db/pizza-seeds.csv", "w", :write_headers => true,
                                    :headers => ["crust", "name", "sauce", "cheese", "toppings"]) do |csv|
  25.times do
    crust = %w(thin thick deep-dish).sample
    name = Faker::Food.dish
    sauce = %w(Red White Korean-BBQ Pesto Tikka-Masala).sample
    cheese = %w(Mozzarella Cheddar Cashew Parmesan).sample
    toppings = Faker::Food.ingredient

    csv << [crust, name, sauce, cheese, toppings]
  end
end
