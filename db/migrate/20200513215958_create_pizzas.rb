class CreatePizzas < ActiveRecord::Migration[6.0]
  def change
    create_table :pizzas do |t|
      t.string :crust
      t.string :name
      t.string :sauce
      t.string :cheese
      t.string :toppings

      t.timestamps
    end
  end
end
