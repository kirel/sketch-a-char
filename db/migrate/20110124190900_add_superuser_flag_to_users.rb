class AddSuperuserFlagToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :superuser, :boolean
  end

  def self.down
    remove_column :users, :superuser
  end
end
