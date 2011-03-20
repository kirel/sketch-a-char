class AddKarmaCacheToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :karma_cache, :integer
    add_index :users, :karma_cache
    
    User.reset_column_information
    User.find_each { |u| u.update_karma_cache! }
  end

  def self.down
    remove_column :users, :karma_cache
  end
end
