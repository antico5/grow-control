class RemoveGrowNameFromReading < ActiveRecord::Migration
  def up
    remove_column :readings, :grow_name
  end

  def down
    add_column :readings, :grow_name, :string
  end
end
