class AddCachedSlugToSym < ActiveRecord::Migration
  def self.up
    add_column :syms, :cached_slug, :string
    add_index  :syms, :cached_slug, :unique => true
  end

  def self.down
    remove_column :syms, :cached_slug
  end
end