class AddExamGroupToExam < ActiveRecord::Migration[5.2]
  def change
    add_reference :exams, :exam_group, foreign_key: true
  end
end
