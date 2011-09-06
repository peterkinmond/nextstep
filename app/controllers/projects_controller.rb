class ProjectsController < ApplicationController
  before_filter :authenticate
  
  def index
    @projects = Project.where(:user_id => current_user)
  end
 
  def show
    @project = Project.find(params[:id])
    @next_step_string = @project.next_step ? @project.next_step.content : 'None'
  end
end
