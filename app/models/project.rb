# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  user_id    :integer
#  status     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Project < ActiveRecord::Base
  attr_accessible :name
                         
  attr_accessible :status
  # TODO: Put values in code somewhere
  # Values:
  # 1 = Active
  # 2 = Done
  # 3 = Archived
  
  belongs_to :user
  has_many :steps
  
  validates :user, :presence => true

  scope :active,    where(:status => 1)
  scope :archived,  where(:status => 0)
  
  def next_step
     self.steps.where(:completed => false).order(:position).first
  end
  
  def next_step_string
    self.next_step ? self.next_step.content : 'None'
  end
end