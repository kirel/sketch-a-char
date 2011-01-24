class CreateSyms < ActiveRecord::Migration
  def self.up
    create_table :syms do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :syms
  end
end
