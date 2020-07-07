class AddValueTypeToAttrClass < ActiveRecord::Migration[5.2]
  def change
    add_column :attr_classes, :value_type, :integer, default: 0
  end
end
