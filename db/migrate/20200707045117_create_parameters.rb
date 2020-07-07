class CreateParameters < ActiveRecord::Migration[5.2]
  def change
    create_table :parameters do |t|
      t.string :param_name
      t.string :param_value
      t.string :value_type

      t.timestamps
    end
  end
end
