class AddExamGroupToPriceListItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :price_list_items, :exam_group, foreign_key: true
  end
end
