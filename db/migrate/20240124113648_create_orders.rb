class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :customerId
      t.string :customerName
      t.string :orderId
      t.integer :totalInCents
      t.datetime :date

      t.timestamps
    end
  end
end
