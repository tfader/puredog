class AddPatronToPatient < ActiveRecord::Migration[5.2]
  def change
    add_reference :patients, :patron, foreign_key: true
  end
end
