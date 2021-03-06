require 'spec_helper'

describe StepsController do
  let(:user) { test_sign_in(FactoryGirl.create(:user)) }
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

  describe "POST 'create'" do
    describe "failure" do
      it "should not create a step" do
        lambda do
          post :create, :project_id => project.id, :step => ""
        end.should_not change(Step, :count)
      end
    end

    describe "success" do
      it "should create a step" do
        lambda do
          post :create, :project_id => project.id, :step => {:content => "New Step"}
        end.should change(Step, :count).by(1)
      end
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      put :edit, :project_id => project.id, :id => step
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "should be successful" do
      get :index, :project_id => project.id
      response.should be_success
    end

    it "should have the right project and ordered steps" do
      get :index, :project_id => project
      assigns(:project).should == project
      assigns(:steps).should == project.steps.order(:position)
    end

    it "ensures user has access to project" do
      user = test_sign_in(FactoryGirl.create(:user, :email => 'user1@example.com'))
      other_user = FactoryGirl.create(:user, :email => 'user2@example.com')
      other_project = other_user.projects.create(:name => "Secret Project")
      get :index, :project_id => other_project
      response.should_not be_success
      response.status.should == 403 # Forbidden access
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
        response.should redirect_to(project_steps_path(step.project))
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
      response.should redirect_to(project_steps_path(step.project))
    end
  end

  describe "GET 'sort'" do
    it "should be successful" do
      step = project.steps.create(:content => "this step")
      get :sort, :project_id => project.id, :step => [step]
      response.should be_success
    end
  end
end
