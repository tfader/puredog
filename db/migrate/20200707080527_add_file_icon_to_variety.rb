class AddFileIconToVariety < ActiveRecord::Migration[5.2]
  def change
    add_column :varieties, :file_icon, :string
  end
end
