class AddDefaultsForCacheColumns < ActiveRecord::Migration
  def self.up
    change_column_default :users, :karma_cache, 0
    change_column_default :samples, :plusminus_cache, 0
  end

  def self.down
    change_column_default :users, :karma_cache, nil
    change_column_default :samples, :plusminus_cache, nil
  end
end
