class StepsController < ApplicationController
  before_filter :authenticate
  before_filter :ensure_user_has_access, :only => [:create, :index, :edit]

  def new
    @step = Step.new
  end

  def create
    step = Step.new(params[:step])
    step.project = @project
    step.save
    @steps = @project.steps.order(:position)
    render :index
  end

  def index
    @steps = @project.steps.order(:position)
  end

  def edit
    @step = Step.find(params[:id])
    if @step.project != @project
      render :nothing => true, :status => 403
    end
  end

  def update
    @step = Step.find(params[:id])
    if @step.update_attributes(params[:step])
      redirect_to project_steps_path(@step.project)
    else
      render 'edit'
    end
  end

  def destroy
    @step = Step.find(params[:id])
    @step.destroy
    redirect_to project_steps_path(@step.project)
  end

  # TODO: Add tests and re-factor
  def sort
    counter = 1
    params['step'].each do |step_id|
      step = Step.find(step_id)
      step.position = counter + 1
      counter +=1
      step.save
    end

    @next_step_string = Project.find(params[:project_id]).next_step_string

    render :index
  end

  def urgent
    @step = Step.find(params[:id])
    @step.urgent = !@step.urgent
    @step.save
  end

  def important
    @step = Step.find(params[:id])
    @step.important = !@step.important
    @step.save
  end

  private

  def ensure_user_has_access
    @project = Project.find(params[:project_id])
    if current_user != @project.user
      render :nothing => true, :status => 403
    end
  end
end
