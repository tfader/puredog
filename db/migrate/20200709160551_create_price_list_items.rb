class CreatePriceListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :price_list_items do |t|
      t.references :price_list, foreign_key: true
      t.references :exam
      t.integer :is_cito, default: 0
      t.decimal :price

      t.timestamps
    end
  end
end
