class ProjectsController < ApplicationController
  before_filter :authenticate
  
  def index
    @projects = Project.all
  end
end
