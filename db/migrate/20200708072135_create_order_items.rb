class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :patient, foreign_key: true
      t.references :exam, foreign_key: true

      t.timestamps
    end
  end
end
