class AddIsArchiveToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :is_archive, :integer, default: 0
  end
end
