class StepsController < ApplicationController
  before_filter :authenticate

  def new
    @step = Step.new
  end

  def create
    @step = Step.new(params[:step])
    if @step.save
      redirect_to project_path(@step.project)
    else
      render :new
    end
  end

  def edit
    @step = Step.find(params[:id])
  end

  def update
    @step = Step.find(params[:id])
    if @step.update_attributes(params[:step])
      redirect_to project_path(@step.project)
    else
      render 'edit'
    end
  end
  
  def destroy
    @step = Step.find(params[:id])
    @step.destroy
    redirect_to project_path(@step.project)
  end
end