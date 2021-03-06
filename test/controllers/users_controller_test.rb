require "test_helper"

describe UsersController do
  describe "login" do
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
      expect(user.username).must_equal "Test User"
    end

    it "can login an existing user" do
      user = User.create(username: "Test Is Best")

      expect{
        login(user.username)
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id
    end
  end

  describe "logout" do
    it "can logout a logged in user" do
      login()
      expect(session[:user_id]).wont_be_nil

      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end

  describe "current_user" do
    it "can return the page if the user is logged in" do
      login()

      get current_user_path

      must_respond_with :success
    end

    it "redirects us back if the user is not logged in" do
      get current_user_path

      must_respond_with :redirect
      expect(flash[:error]).must_equal "You must be logged in to do that!"
    end
  end
end
