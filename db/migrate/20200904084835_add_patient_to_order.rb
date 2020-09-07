class AddPatientToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :patient, foreign_key: true
  end
end
