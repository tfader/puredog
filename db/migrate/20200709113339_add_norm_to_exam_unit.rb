class AddNormToExamUnit < ActiveRecord::Migration[5.2]
  def change
    add_column :exam_units, :norm_min, :decimal
    add_column :exam_units, :norm_max, :decimal
  end
end
