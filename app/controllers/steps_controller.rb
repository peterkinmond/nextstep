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
  
  def destroy
     @step = Step.find(params[:id])
     @step.destroy
     redirect_to project_path(@step.project)
  end
end
