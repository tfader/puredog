class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.references :spot, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
