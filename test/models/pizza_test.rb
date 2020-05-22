require "test_helper"

describe Pizza do
  describe "validations" do
    it "is valid when all fields are present" do
      expect(pizzas(:pepperoni).valid?).must_equal true
    end
    it "is valid when only crust and name are present" do
      pepperoni_test = pizzas(:pepperoni)
      pepperoni_test.crust = nil  

      expect(pepperoni_test.valid?).must_equal false
    end
    it "is invalid when crust is missing" do
      expect(pizzas(:invalid_pizza).valid?).must_equal false
    end
  end

  describe "get_top_ten" do
    it "will get 10 pizzas" do

    end

    it "will get 10 pizzas whose votes are highest" do

    end

    it "will return nil if no pizzas are in a category" do

    end
  end
end
