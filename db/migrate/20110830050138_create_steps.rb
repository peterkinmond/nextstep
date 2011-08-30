class CreateSteps < ActiveRecord::Migration
  def self.up
    create_table :steps do |t|
      t.integer :project_id
      t.text :content 
      t.integer :estimated_time
      t.boolean :completed

      t.timestamps
    end
  end

  def self.down
    drop_table :steps
  end
end
