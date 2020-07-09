class AddUnitToOrderItemResult < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_item_results, :unit, foreign_key: true
  end
end
