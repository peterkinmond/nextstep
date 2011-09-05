require 'spec_helper'

describe StepsController do
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
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
        @attr = { :content => "New Step" }
      end

      # it "should create a step" do
      #   lambda do
      #     post :create, :step => @attr
      #   end.should change(Step, :count).by(1)
      # end  

      # it "should redirect to the user show page" do
      #    post :create, :user => @attr
      #    response.should redirect_to(user_path(assigns(:user))) 
      # end     
    end
  end
end
