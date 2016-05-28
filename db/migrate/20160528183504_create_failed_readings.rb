class CreateFailedReadings < ActiveRecord::Migration
  def change
    create_table :failed_readings do |t|
      t.string :grow_name
      t.string :humidity
      t.string :temperature

      t.timestamps null: false
    end
  end
end
