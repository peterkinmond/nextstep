# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Project < ActiveRecord::Base
  attr_accessible :name
  
  belongs_to :user
end
