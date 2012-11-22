class ProjectsController < ApplicationController
  before_filter :authenticate
  before_filter :ensure_user_has_access, :only => [:edit, :update, :destroy, :archive]

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

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      redirect_to projects_path
    else
      render 'edit'
    end
  end

  def destroy
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
    @project.status = 0
    @project.save
    redirect_to projects_path
  end

  def ensure_user_has_access
    @project = Project.find(params[:id])
    if current_user != @project.user
      render :nothing => true, :status => 403
    end
  end
end
