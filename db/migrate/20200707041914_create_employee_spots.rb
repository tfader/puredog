class CreateEmployeeSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_spots do |t|
      t.references :employee, foreign_key: true
      t.references :spot, foreign_key: true
      t.date :date_from
      t.date :date_to

      t.timestamps
    end
  end
end
