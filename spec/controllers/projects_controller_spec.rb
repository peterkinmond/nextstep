require 'spec_helper'

describe ProjectsController do
  render_views
  
  describe "GET 'index'" do 
    
    describe "user associations" do
    
      before(:each) do
         @user1 = test_sign_in(Factory(:user))
         @user1project = @user1.projects.create(:name => "User 1's Project")
         
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
   end
  end
end
