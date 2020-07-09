class CreateOrderItemResults < ActiveRecord::Migration[5.2]
  def change
    create_table :order_item_results do |t|
      t.references :order_item, foreign_key: true
      t.decimal :result
      t.datetime :result_time

      t.timestamps
    end
  end
end
