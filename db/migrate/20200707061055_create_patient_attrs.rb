class CreatePatientAttrs < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_attrs do |t|
      t.references :attr, foreign_key: true
      t.integer :mandatory, default: 0

      t.timestamps
    end
  end
end
