class ProjectsController < ApplicationController
  before_filter :authenticate
  
  def index
    @projects = Project.where(:user_id => current_user)
  end
end
