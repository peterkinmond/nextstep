require 'spec_helper'

describe Step do
  it { should belong_to(:project) }
  it { should validate_presence_of(:content)}
  it { should validate_presence_of(:project)}
  it { should have_db_column(:completed).of_type(:boolean)}  
  it { should have_db_column(:urgent).of_type(:boolean)} 
  it { should have_db_column(:important).of_type(:boolean)} 
end                                    
