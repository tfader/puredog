class CreateStationExams < ActiveRecord::Migration[5.2]
  def change
    create_table :station_exams do |t|
      t.references :station, foreign_key: true
      t.references :exam, foreign_key: true

      t.timestamps
    end
  end
end
