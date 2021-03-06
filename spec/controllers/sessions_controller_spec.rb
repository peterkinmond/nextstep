require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do

    it "should be successful" do
      get :new
      response.should be_success
    end

    context "when user is already signed in" do
      before(:each) do
        test_sign_in(FactoryGirl.create(:user))
      end
      it "should redirect to Projects page" do
        get :new
        response.should redirect_to(projects_path)
      end
    end    

    context "when user is NOT signed in" do 
      it "should have the right title" do
        get :new
        response.should have_selector('title', :content => "Sign in")
      end
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { :email => "", :password => "" }
        post :create, :session => @attr
      end

      it "should re-render the page" do
        response.should render_template('new')
      end

      it "should have an error message" do
        flash.now[:error].should =~ /invalid/i
      end

      it "should have the right title" do
        response.should have_selector('title', :content => "Sign in")
      end
    end

    describe "success" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        @attr = { :email => @user.email, :password => @user.password }
      end

      it "should sign the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end

      it "should redirect to the projects index page" do
        post :create, :session => @attr
        response.should redirect_to(projects_path)
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "should sign a user out" do
      test_sign_in(FactoryGirl.create(:user))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end
end
