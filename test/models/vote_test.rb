require "test_helper"

describe Vote do
  before do
    @user = users(:brock)
    @pizza = pizzas(:pepperoni)
    @vote = Vote.new(user: @user, pizza: @pizza)
  end

  describe "validations" do
    it "will be valid when all fields are filled" do
      expect(@vote.valid?).must_equal true
    end

    it "won't be valid if a user or pizza is missing" do
      no_user = @vote
      no_user.user_id = nil

      no_pizza = @vote
      no_pizza.pizza_id = nil

      expect(no_user.valid?).must_equal false
      expect(no_pizza.valid?).must_equal false
    end
  end

  describe "relations" do
    describe "votes" do
      it "can be created using 'user' and 'pizza'" do
        test_vote = Vote.new

        test_vote.user = @user
        test_vote.pizza = @pizza

        expect(test_vote.user_id).must_equal @user.id
        expect(test_vote.pizza_id).must_equal @pizza.id
      end

      it "can be created using 'user_id' and 'pizza_id'" do
        test_vote = Vote.new

        test_vote.user_id = @user.id
        test_vote.pizza_id = @pizza.id

        expect(test_vote.user).must_equal @user
        expect(test_vote.pizza).must_equal @pizza
      end
    end
  end
end
