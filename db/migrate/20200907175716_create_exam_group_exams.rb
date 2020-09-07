class CreateExamGroupExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exam_group_exams do |t|
      t.references :exam_group, foreign_key: true
      t.references :exam, foreign_key: true

      t.timestamps
    end
  end
end
