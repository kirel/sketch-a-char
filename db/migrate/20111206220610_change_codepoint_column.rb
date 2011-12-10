class ChangeCodepointColumn < ActiveRecord::Migration
  def up
    remove_column :representations, :codepoint
    add_column :representations, :codepoint, :integer
  end

  def down
    remove_column :representations, :codepoint
    add_column :representations, :codepoint, :string
  end
end
