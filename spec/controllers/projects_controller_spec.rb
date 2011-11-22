require 'spec_helper'

describe ProjectsController do
  render_views

  describe "access control" do
    it "should deny access to 'index'" do
      get :index
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
    describe "success" do
      before(:each) do
        @user = test_sign_in(Factory(:user))  
        @project = @user.projects.create(:name => "New Project")
      end

      it "should create a project" do
        lambda do
          post :create, :project  => @project
        end.should change(Project, :count).by(1)
      end

      it "should redirect to the project index page" do
        post :create, :project => @project
        response.should redirect_to(projects_path)
      end 
    end
  end

  describe "GET 'index'" do 

    describe "user associations" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @project = @user.projects.create(:name => "User 1's Project")

        @other_user = Factory(:user, :email => Factory.next(:email)) 
        @other_user_project = @other_user.projects.create(:name => "Other user's project")
      end

      it "should be successful" do
        get :index
        response.should be_success
      end 

      it "should show projects that belong to current user" do
        get :index      
        response.should have_selector('td.projectname', :content => "User 1's Project")
      end                            

      it "should NOT show projects that DO NOT belong to current user" do
        get :index
        response.should_not have_selector('td.projectname', :content => "Other user's project")
      end

      it "should link to project" do
        get :index
        response.should have_selector('a',  :href => project_steps_path(@project),
        :content => "User 1's Project")
      end

      it "should show the next step for each project" do
        get :index
        response.should have_selector('td.nextstep', :content => "None")
      end
    end
  end
  
  describe "GET 'todo'" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    it "should be successful" do
      get :todo
      response.should be_success
    end
  end
end
