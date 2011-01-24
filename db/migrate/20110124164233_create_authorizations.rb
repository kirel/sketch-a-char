class CreateAuthorizations < ActiveRecord::Migration
  def self.up
    create_table :authorizations do |t|
      t.string :provide
      t.string :uid
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :authorizations
  end
end
