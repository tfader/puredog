class CreateExamUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :exam_units do |t|
      t.references :exam, foreign_key: true
      t.references :unit, foreign_key: true
      t.integer :is_default, default: 1

      t.timestamps
    end
  end
end
