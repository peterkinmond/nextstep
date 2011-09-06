require 'spec_helper'

describe Project do
  describe "relationships" do
    it { should belong_to(:user) } 
    it { should have_many(:steps) }
  end

  describe "#next_step" do
    before(:each) do
      @project = Factory.create(:project)
      @completed_step = @project.steps.create(:content => "completed step", :completed => true)
      @uncompleted_step = @project.steps.create(:content => "uncompleted step", :completed => false)
      
      @empty_project = Project.new(:name => "Empty project")
    end

    it "should find the first uncompleted step for the project" do
      @project.next_step.should == @uncompleted_step
    end
    
    it "should return nil if no uncompleted steps left in project" do
       @empty_project.next_step.should == nil
    end
  end
end
