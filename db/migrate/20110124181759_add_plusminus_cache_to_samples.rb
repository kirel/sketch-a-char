class AddPlusminusCacheToSamples < ActiveRecord::Migration
  def self.up
    add_column :samples, :plusminus_cache, :integer
    add_index  :samples, :plusminus_cache
  end

  def self.down
    remove_column :samples, :plusminus_cache
  end
end
