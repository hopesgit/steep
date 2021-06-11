class UpdateTableIndexes < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :subscriptions, :customers, column: :customer_id
  end
end
