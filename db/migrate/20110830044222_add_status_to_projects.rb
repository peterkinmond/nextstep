class AddStatusToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :status, :integer, :default => 1
  end

  def self.down
    remove_column :projects, :status
  end
end
