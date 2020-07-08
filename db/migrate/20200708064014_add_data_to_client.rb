class AddDataToClient < ActiveRecord::Migration[5.2]
  def change
    add_reference :clients, :city, foreign_key: true
    add_column :clients, :street, :name
    add_column :clients, :code, :string
  end
end
