class SessionsController < ApplicationController
  def new
     @title = "Sign in"
     if signed_in?
        redirect_to projects_path
     end
  end
  
  def create
    user = User.authenticate( params[:session][:email],
                              params[:session][:password])
    if user.nil?
      @title = "Sign in"
      flash.now[:error] = "Invalid email and password combination."
      render 'new'      
    else
      sign_in user
      redirect_back_or projects_path
    end
  end  
  
  def destroy
    sign_out
    redirect_to root_path
  end 
end
