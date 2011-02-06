class CreateRepresentations < ActiveRecord::Migration
  def self.up
    create_table :representations do |t|
      t.string :package
      t.string :command
      t.string :codepoint
      t.string :type
      t.references :sym

      t.timestamps
    end
  end

  def self.down
    drop_table :representations
  end
end
