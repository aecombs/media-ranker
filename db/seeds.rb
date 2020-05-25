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



USER_FILE = Rails.root.join('db', 'users-seeds.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.username = row['username']
  successful = user.save
  if !successful
    user_failures << user
    puts "Failed to save user: #{user.inspect}"
  else
    puts "Created user: #{user.inspect}"
  end
end

puts "Added #{User.count} user records."
puts "#{user_failures.length} users failed to save."

puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "All done!"