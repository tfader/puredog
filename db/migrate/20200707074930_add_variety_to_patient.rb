class AddVarietyToPatient < ActiveRecord::Migration[5.2]
  def change
    add_reference :patients, :variety, foreign_key: true
  end
end
