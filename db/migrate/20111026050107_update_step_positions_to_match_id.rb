class UpdateStepPositionsToMatchId < ActiveRecord::Migration
  def self.up
    Step.all.each {|i| i.update_attribute(:position, i.id)}
  end

  def self.down
    Step.all.each {|i| i.update_attribute(:position, nil)}
  end
end
