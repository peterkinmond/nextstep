require 'spec_helper'

describe StepsController do
  let(:user) { test_sign_in(Factory(:user)) }
  let(:project) { user.projects.create(:name => "La Project Du Pierre")}
  let(:step) { project.steps.create(:content => "this step") }

  describe "access control" do
    it "should deny access to 'create'" do
      post :create, :project_id => 1
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1, :project_id => 1 
      response.should redirect_to(signin_path)
    end       
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new, :project_id => project.id
      response.should be_success
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      it "should be successful" do
        post :create, :project_id => project.id, :step => ""
        response.should be_success
      end

      it "should redirect to the 'new' page" do
        post :create, :project_id => project.id, :step => ""
        response.should render_template('new')
      end                            

      it "should not create a step" do
        lambda do
          post :create, :project_id => project.id, :step => ""
        end.should_not change(Step, :count)
      end
    end

    describe "success" do
      it "should create a step" do
        post :create, :project_id => project.id, :step => "New Step"
        response.should be_success
      end  
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      put :edit, :project_id => project.id, :id => step
      response.should be_success
    end
  end

  describe "PUT 'update'" do
    describe "failure" do
      before(:each) do
        @attr = { :content => ""}   
      end

      it "should render the 'edit' page" do
        put :update, :project_id => project.id, :id => step, :step => @attr
        response.should render_template('edit')
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :content => "updated step content", :estimated_time => 45}   
      end
      
      it "should change the step's attributes" do
         put :update, :project_id => project.id, :id => step, :step => @attr
         step.reload
         step.content.should == "updated step content"
         step.estimated_time.should == 45
      end  
      
      it "should redirect to the project page" do
        put :update, :project_id => project.id, :id => step, :step => @attr
        response.should redirect_to(project_path(step.project))
      end
    end
  end

  describe "DELETE 'destroy'" do 
    before(:each) do
      @step = project.steps.create(:content => "this step")
    end

    it "should destroy the step" do
      lambda do
        delete :destroy, :project_id => project.id, :id => @step
      end.should change(Step, :count).by(-1)
    end

    it "should redirect to the project page" do
      delete :destroy, :project_id => project.id, :id => step
      response.should redirect_to(project_path(step.project))
    end
  end
end