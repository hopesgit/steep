class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.integer :customer_id
      t.integer :tea_id
      t.integer :status

      t.timestamps
    end
  end
end
