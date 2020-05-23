require "test_helper"

describe UsersController do
  describe "session" do
    it "can get the login form" do
      get login_path

      must_respond_with :success
    end

    it "can login a new user" do
      user = nil
      #login method located in test_helper.rb
      expect {
        user = login()
      }.must_differ "User.count", 1

      must_respond_with :redirect

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal user_hash[:user][:username]
    end

    it "can login an existing user" do
      user = User.create(username: "Test Is Best")

      expect{
        login(user.username)
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id
    end
  end
end
