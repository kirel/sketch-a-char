class ChangeCodepointColumn < ActiveRecord::Migration
  def up
    change_table(:representations) do |t|
      t.change :codepoint, :integer
    end
  end

  def down
    change_table(:representations) do |t|
      t.change :codepoint, :string
    end
  end
end
