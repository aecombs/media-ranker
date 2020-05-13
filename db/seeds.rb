# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

PIZZA_FILE = Rails.root.join('db', 'pizzas-seeds.csv')
puts "Loading raw pizza data from #{PIZZA_FILE}"

pizza_failures = []
CSV.foreach(PIZZA_FILE, :headers => true) do |row|
  pizza = Pizza.new
  pizza.crust = row['crust']
  pizza.name = row['name']
  pizza.sauce = row['sauce']
  pizza.cheese = row['cheese']
  pizza.toppings = row['toppings']
  successful = pizza.save
  if !successful
    pizza_failures << pizza
    puts "Failed to save pizza: #{pizza.inspect}"
  else
    puts "Created pizza: #{pizza.inspect}"
  end
end

puts "Added #{Pizza.count} pizza records."
puts "#{pizza_failures.length} pizzas failed to save."

puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "All done!"