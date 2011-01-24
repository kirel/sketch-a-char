class AddSubmitterIdToSamples < ActiveRecord::Migration
  def self.up
    add_column :samples, :submitter_id, :integer
  end

  def self.down
    remove_column :samples, :submitter_id
  end
end
