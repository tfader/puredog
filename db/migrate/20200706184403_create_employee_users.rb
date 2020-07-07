class CreateEmployeeUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :employee_users do |t|
      t.references :employee, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end