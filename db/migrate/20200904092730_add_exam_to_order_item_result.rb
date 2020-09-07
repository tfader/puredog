class AddExamToOrderItemResult < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_item_results, :exam, foreign_key: true
  end
end
