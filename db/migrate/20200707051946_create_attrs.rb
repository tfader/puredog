class CreateAttrs < ActiveRecord::Migration[5.2]
  def change
    create_table :attrs do |t|
      t.references :attr_class, foreign_key: true
      t.string :name
      t.integer :value_type, default: 0

      t.timestamps
    end
  end
end
