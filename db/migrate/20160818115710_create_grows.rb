class CreateGrows < ActiveRecord::Migration
  def change
    create_table :grows do |t|
      t.string :name
      t.datetime :start_date

      t.timestamps null: false
    end
  end
end
