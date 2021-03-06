class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.string :name
      t.string :street
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
