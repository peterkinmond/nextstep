class AddDefaultValueToStepCompleted < ActiveRecord::Migration
  def self.up
     change_column_default :steps, :completed, false
  end

  def self.down    
  end
end
