class AddNormToExamUnit < ActiveRecord::Migration[5.2]
  def change
    add_column :exam_units, :norm_min, :integer
    add_column :exam_units, :norm_max, :integer
  end
end
