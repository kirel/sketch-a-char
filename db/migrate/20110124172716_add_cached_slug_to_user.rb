class AddCachedSlugToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :cached_slug, :string
    add_index  :users, :cached_slug, :unique => true
  end

  def self.down
    remove_column :users, :cached_slug
  end  
end
