class RenameProvider < ActiveRecord::Migration
  def self.up
    rename_column :authorizations, :provide, :provider
  end

  def self.down
    rename_column :authorizations, :provider, :provide
  end
end
