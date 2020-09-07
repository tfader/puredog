class AddExamGroupToOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_items, :exam_group, foreign_key: true
  end
end
