class AddCitoToOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :is_cito, :integer, default: 0
  end
end
