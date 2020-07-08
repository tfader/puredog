class AddOrderFlowToOrderStatus < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_statuses, :order_flow, foreign_key: true
  end
end
