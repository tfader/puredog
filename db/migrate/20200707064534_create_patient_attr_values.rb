class CreatePatientAttrValues < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_attr_values do |t|
      t.references :patient, foreign_key: true
      t.references :attr, foreign_key: true
      t.string :attr_value

      t.timestamps
    end
  end
end
