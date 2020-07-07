class AddDefaultToCity < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :default, :integer, default: 0
  end
end
