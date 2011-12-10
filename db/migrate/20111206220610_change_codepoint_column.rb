class ChangeCodepointColumn < ActiveRecord::Migration
  def up
    change_table(:representations) do |t|
      t.remove :codepoint
      t.add :codepoint, :integer
    end
  end

  def down
    change_table(:representations) do |t|
      t.remove :codepoint
      t.add :codepoint, :string
    end
  end
end
