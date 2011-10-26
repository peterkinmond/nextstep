require 'spec_helper'

describe Step do
  it { should belong_to(:project) }

  it { should validate_presence_of(:content)}
  it { should validate_presence_of(:project)}

  it { should have_db_column(:completed).of_type(:boolean)}  
  it { should have_db_column(:urgent).of_type(:boolean)} 
  it { should have_db_column(:important).of_type(:boolean)} 
  it { should have_db_column(:position).of_type(:integer)}

  it { should allow_mass_assignment_of(:content)}
  it { should allow_mass_assignment_of(:estimated_time)}
  it { should allow_mass_assignment_of(:completed)}
  it { should allow_mass_assignment_of(:urgent)}
  it { should allow_mass_assignment_of(:important)}
  it { should allow_mass_assignment_of(:position)}
end                                    
