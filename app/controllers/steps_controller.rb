class StepsController < ApplicationController
  before_filter :authenticate

  def new
    @step = Step.new
  end

  def create
    @project = Project.find(params[:project_id])
    step = Step.new(params[:step])
    step.project = @project
    step.save
    @steps = @project.steps
    render :index
  end

  def index
    @project = Project.find(params[:project_id]) 
    @steps = @project.steps.order('position ASC')
  end

  def edit
    @project = Project.find(params[:project_id])    
    @step = Step.find(params[:id])
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
    
    render :nothing => true
  end
end