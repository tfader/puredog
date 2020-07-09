class AddCitoToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :is_cito, :integer, default: 0
  end
end
