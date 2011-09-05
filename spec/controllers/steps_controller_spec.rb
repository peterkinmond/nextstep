require 'spec_helper'

describe StepsController do

  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    xit "should deny access to 'destroy'" do
      delete :destroy, :id => 1 
      response.should redirect_to(signin_path)
    end       
  end

  describe "GET 'new'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))  
    end 

    it "should be successful" do
      get :new
      response.should be_success
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @user = test_sign_in(Factory(:user))  
        @attr = { :content => ""}
      end

      it "should be successful" do
        post :create, :step => @attr
        response.should be_success
      end

      it "should redirect to the 'new' page" do
        post :create, :step => @attr
        response.should render_template('new')
      end                            

      it "should not create a step" do
        lambda do
          post :create, :step => @attr
        end.should_not change(Step, :count)
      end
    end

    describe "success" do
      before(:each) do
        @user = test_sign_in(Factory(:user))  
        @attr = { :content => "New Step" }
      end

      it "should create a step" do
        post :create, :step => @attr
        response.should be_success
      end  
    end
  end

  describe "DELETE 'destroy'" do 
    # TODO: Replace pile of setup non-sense with something cleaner
    before(:each) do
      @user = test_sign_in(Factory(:user)) 
      @project = @user.projects.create(:name => "this project")
      # @step = Factory(:step)   
      @step = @project.steps.create(:content => "htis step")
    end
    
    it "should be successful" do
        delete :destroy, :id => @step
        response.should be_success
    end
  end
end