require 'spec_helper'

describe StepsController do

  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
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

  describe "GET 'edit'" do
    # TODO: Replace pile of setup nonsense with something cleaner
    before(:each) do
      @user = test_sign_in(Factory(:user)) 
      @project = @user.projects.create(:name => "this project")
      @step = @project.steps.create(:content => "this step")
    end

    it "should be successful" do
      put :edit, :id => @step
      response.should be_success
    end
  end

  describe "PUT 'update'" do
    # TODO: Replace pile of setup nonsense with something cleaner
    before(:each) do
      @user = test_sign_in(Factory(:user)) 
      @project = @user.projects.create(:name => "this project")
      @step = @project.steps.create(:content => "this step")
    end

    describe "failure" do
      before(:each) do
        @attr = { :content => ""}   
      end

      it "should render the 'edit' page" do
        put :update, :id => @step, :step => @attr
        response.should render_template('edit')
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :content => "updated step content", :estimated_time => 45}   
      end
      
      it "should change the step's attributes" do
         put :update, :id => @step, :step => @attr
         @step.reload
         @step.content.should == "updated step content"
         @step.estimated_time.should == 45
      end  
      
      it "should redirect to the project page" do
        put :update, :id => @step, :step => @attr
        response.should redirect_to(project_path(@step.project))
      end
    end
  end

  describe "DELETE 'destroy'" do 
    # TODO: Replace pile of setup nonsense with something cleaner
    before(:each) do
      @user = test_sign_in(Factory(:user)) 
      @project = @user.projects.create(:name => "this project")
      @step = @project.steps.create(:content => "this step")
    end

    it "should destroy the step" do
      lambda do
        delete :destroy, :id => @step
      end.should change(Step, :count).by(-1)
    end

    it "should redirect to the project page" do
      delete :destroy, :id => @step
      response.should redirect_to(project_path(@step.project))
    end
  end
end