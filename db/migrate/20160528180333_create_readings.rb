class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.string :grow_name
      t.float :humidity
      t.float :temperature

      t.timestamps null: false
    end
  end
end
