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
    @projects = Project.active.where(:user_id => current_user)
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
    next_steps_unsorted = Project.active.where(:user_id => current_user).
        map(&:next_step).compact.reject(&:waiting?)

    @next_steps = next_steps_unsorted.
        sort_by { |step, _| [step.important ? -1 : 1, step.urgent ? -1 : 1] }
  end

  def archive
    @project = Project.find(params[:id])
    @project.status = 0
    @project.save
    redirect_to projects_path
  end
end
