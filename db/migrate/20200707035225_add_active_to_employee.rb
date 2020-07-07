class AddActiveToEmployee < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :active, :integer, default: 1
  end
end
