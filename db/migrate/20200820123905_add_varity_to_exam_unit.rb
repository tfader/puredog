class AddVarityToExamUnit < ActiveRecord::Migration[5.2]
  def change
    add_reference :exam_units, :variety, foreign_key: true
  end
end
