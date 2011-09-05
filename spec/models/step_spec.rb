require 'spec_helper'

describe Step do
  it { should belong_to(:project) }
  it { should validate_presence_of(:content)}
  it { should validate_presence_of(:project)}
end
