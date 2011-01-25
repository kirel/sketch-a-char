class ChangeDataToTextInSamples < ActiveRecord::Migration
  def self.up
    change_column :samples, :data, :text
  end

  def self.down
    change_column :samples, :data, :binary
  end
end
