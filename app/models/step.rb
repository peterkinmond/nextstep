# == Schema Information
#
# Table name: steps
#
#  id             :integer         not null, primary key
#  project_id     :integer
#  content        :text
#  estimated_time :integer
#  completed      :boolean
#  created_at     :datetime
#  updated_at     :datetime
#

class Step < ActiveRecord::Base
  attr_accessible :content, :estimated_time, :completed
  
  belongs_to :project
end
