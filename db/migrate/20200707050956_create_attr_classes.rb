class CreateAttrClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :attr_classes do |t|
      t.string :name

      t.timestamps
    end
  end
end
