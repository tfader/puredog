class AddNameToPriceList < ActiveRecord::Migration[5.2]
  def change
    add_column :price_lists, :name, :string
    add_column :price_lists, :is_cito, :integer, default: 0
  end
end
