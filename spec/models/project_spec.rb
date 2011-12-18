require 'spec_helper'

describe Project do
  describe "relationships" do
    it { should belong_to(:user) } 
    it { should have_many(:steps) }
  end

  describe "#next_step" do
    before(:each) do
      @project = Factory.create(:project)
      @completed_step = Step.create(:content => "completed step", :completed => true)
      @uncompleted_step1 = Step.create(:content => "uncompleted step",   :position => 2, :completed => false)
      @uncompleted_step2 = Step.create(:content => "uncompleted step 2", :position => 1, :completed => false)
      @project.steps = [@completed_step, @uncompleted_step1, @uncompleted_step2]

      @empty_project = Project.new(:name => "Empty project")
    end

    it "should find the uncompleted step with the lowest position for the project" do
      @project.next_step.should == @uncompleted_step2
    end
    
    it "should return nil if no uncompleted steps left in project" do
       @empty_project.next_step.should == nil
    end
  end
end
