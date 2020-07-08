class CreateOrderFlows < ActiveRecord::Migration[5.2]
  def change
    create_table :order_flows do |t|
      t.string :name
      t.integer :flow_step

      t.timestamps
    end
  end
end
