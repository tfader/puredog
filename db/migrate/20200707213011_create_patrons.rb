class CreatePatrons < ActiveRecord::Migration[5.2]
  def change
    create_table :patrons do |t|
      t.string :first_name
      t.string :last_name
      t.string :public_id

      t.timestamps
    end
  end
end
