class ProjectsController < ApplicationController
  before_filter :authenticate

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(params[:project])
    if @project.save
      redirect_to projects_path
    else
      render :new
    end
  end

  def index
    @projects = Project.where(:user_id => current_user)
  end

  def show
    @project = Project.find(params[:id])
  end  
  
  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to projects_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path
  end
  
  def todo
    @projects = Project.where(:user_id => current_user)
  end
end
