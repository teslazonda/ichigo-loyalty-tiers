# db/migrate/[timestamp]_create_users.rb

class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :current_tier
      t.integer :amount_spent_since_last_year
      t.integer :amount_needed_for_next_tier
      t.string :downgraded_tier
      t.integer :amount_needed_to_avoid_downgrade
      t.string :name

      t.timestamps
    end
  end
end
