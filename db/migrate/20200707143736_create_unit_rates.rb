class CreateUnitRates < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_rates do |t|
      t.integer :from_unit_id
      t.integer :to_unit_id
      t.integer :rate_from, default: 1
      t.integer :rate_to, default: 1

      t.timestamps
    end
    add_index :unit_rates, :from_unit_id
    add_index :unit_rates, :to_unit_id
  end

end
