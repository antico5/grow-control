class AddGrowIdToReadings < ActiveRecord::Migration
  def up
    add_column :readings, :grow_id, :integer
    assign_readings_to_default_grow
  end

  def down
    remove_column :readings, :grow_id
  end

  def assign_readings_to_default_grow
    grow = Grow.find_or_create_by name: 'default'
    Reading.update_all grow_id: grow.id
  end
end
