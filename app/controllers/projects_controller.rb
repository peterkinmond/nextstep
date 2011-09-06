class ProjectsController < ApplicationController
  before_filter :authenticate
  
  def index
    @projects = Project.where(:user_id => current_user)
  end
 
  def show
    @project = Project.find(params[:id])
  end
end
