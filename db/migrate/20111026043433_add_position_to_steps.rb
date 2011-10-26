class AddPositionToSteps < ActiveRecord::Migration
  def self.up
    add_column :steps, :position, :int
  end

  def self.down
    remove_column :steps, :position
  end
end
