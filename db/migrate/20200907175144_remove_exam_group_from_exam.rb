class RemoveExamGroupFromExam < ActiveRecord::Migration[5.2]
  def change
    remove_column :exams, :exam_group_id, :integer
  end
end
