class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :spot, foreign_key: true
      t.references :client, foreign_key: true
      t.date :ordered
      t.date :placed
      t.string :order_number

      t.timestamps
    end
  end
end
