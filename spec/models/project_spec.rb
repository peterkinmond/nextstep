require 'spec_helper'

describe Project do
  describe "relationships" do
    it { should belong_to(:user) } 
    it { should have_many(:steps) }
  end
end
