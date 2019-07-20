class CreateReadings < ActiveRecord::Migration[5.2]
  def change
    create_table :readings do |t|
      t.references :thermostat, index: true, foreign_key: true, null: false
      t.integer :tracking_number, null: false
      t.float :temperature, null: false
      t.float :humidity, null: false
      t.float :battery_charge, null: false

      t.timestamps
    end
  end
end
