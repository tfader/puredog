class AddGeneralToPriceList < ActiveRecord::Migration[5.2]
  def change
    add_column :price_lists, :is_general, :integer, default: 0
  end
end
