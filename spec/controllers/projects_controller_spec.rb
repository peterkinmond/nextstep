require 'spec_helper'

describe ProjectsController do
  render_views
  
  describe "access control" do
    it "should deny access to 'index'" do
      get :index
      response.should redirect_to(signin_path)
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
          response.should have_selector('a',  :href => project_path(@project),
                                              :content => "User 1's Project")
       end
   end
  end

  describe "GET 'show'" do
    
    before(:each) do
       @user = test_sign_in(Factory(:user))
       @project = @user.projects.create(:name => "La Project Du Pierre")
    end
    
     it "should be successful" do
        get :show, :id => @project
        response.should be_success
     end
     
     it "should have the right project" do
        get :show, :id => @project
        assigns(:project).should == @project
     end
  end
end
