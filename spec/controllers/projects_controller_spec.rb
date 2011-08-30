require 'spec_helper'

describe ProjectsController do
  describe "GET 'index'" do
    
    before(:each) do
       @user = test_sign_in(Factory(:user))
    end
    
     it "should be successful" do
        get :index
        response.should be_success
     end
  end
end
