require "test_helper"

describe Pizza do
  describe "validations" do
    it "is valid when all fields are present" do
      expect(pizzas(:pepperoni).valid?).must_equal true
    end

    it "is valid when only crust and name are present" do
      pepperoni_test = pizzas(:pepperoni)
      pepperoni_test.sauce = nil
      pepperoni_test.cheese = nil
      pepperoni_test.toppings = nil

      expect(pepperoni_test.valid?).must_equal true
    end

    it "is invalid when crust or name is missing" do
      invalid_pepperoni = pizzas(:pepperoni)
      invalid_pepperoni.crust = nil  

      invalid_bbq = pizzas(:bbq)
      invalid_bbq.name = nil  

      expect(invalid_pepperoni.valid?).must_equal false
      expect(invalid_bbq.valid?).must_equal false
    end
  end

  describe "get_top" do
    it "can take a crust as an argument" do
      expect(Pizza.get_top("thin").length).must_equal 6
      expect(Pizza.get_top).wont_be_empty
    end

    it "will return all pizzas in an altered order with no arguments" do
      pizzas = Pizza.all
      expect(Pizza.get_top.length).must_equal 11
      expect(Pizza.get_top).wont_be_empty
      expect(Pizza.get_top).wont_be_same_as pizzas
      expect(Pizza.get_top).must_include pizzas.first
    end

    it "will order pizzas with votes length descending" do
      pizzas = Pizza.all
      top_pizza = pizzas.max_by{ |p| p.votes.length }
      expect(Pizza.get_top.first).must_equal top_pizza
    end

    it "will return nil if no pizzas are in a category" do
      new_crust = "sicilian"
      expect(Pizza.get_top(new_crust)).must_be_nil
    end
  end

  describe "get_spotlight" do
    it "will return a single pizza" do
      spotlight = Pizza.get_spotlight

      expect(spotlight).must_be_instance_of Pizza
      expect(spotlight).must_respond_to :name
      expect(spotlight).must_respond_to :crust
    end

    it "will return the pizza with the most votes" do
      top_pizza = Pizza.all.max_by{ |p| p.votes.length }
      spotlight = Pizza.get_spotlight

      expect(spotlight.name).must_match top_pizza.name
    end
  end
end
