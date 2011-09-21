class AddPriorityToSteps < ActiveRecord::Migration
  def self.up
    add_column :steps, :urgent, :boolean, :default => false
    add_column :steps, :important, :boolean, :default => false
  end

  def self.down
    remove_column :steps, :important
    remove_column :steps, :urgent
  end
end
