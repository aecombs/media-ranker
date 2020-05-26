require "test_helper"

describe User do
  describe "validations" do
    it "is valid when username is present" do
      expect(users(:brock).valid?).must_equal true
    end

    it "is valid when username has letters and numbers" do
      expect(users(:angelica).valid?).must_equal true
    end

    it "is invalid when username is missing" do
      user_test = users(:brock)
      user_test.username = nil
      expect(user_test.valid?).must_equal false
    end

    it "is invalid when username has non-letter or non-number chars" do
      expect(users(:invalid).valid?).must_equal false
      expect(users(:invalid_tarik).valid?).must_equal false
    end
  end

  describe "relations" do
    before do
      @brock_vote = Vote.create!(user: users(:brock), pizza: pizzas(:pepperoni))
    end

    it "can have votes" do
      expect(users(:brock).votes).wont_be_nil
      expect(users(:brock).votes.first.pizza.name).must_match @brock_vote.pizza.name
    end

    
  end
end
