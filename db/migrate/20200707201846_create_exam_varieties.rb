class CreateExamVarieties < ActiveRecord::Migration[5.2]
  def change
    create_table :exam_varieties do |t|
      t.references :exam, foreign_key: true
      t.references :variety, foreign_key: true

      t.timestamps
    end
  end
end
