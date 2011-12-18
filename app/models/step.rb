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
  attr_accessible :content, :estimated_time, :completed, :urgent, :important, :position
  
  belongs_to :project
  
  validates :content,     :presence => true
  validates :project,  :presence => true
  
  after_create  :set_position
  
  def set_position
     self.position ||= self.id
     self.save
  end
end
