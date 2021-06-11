class ChangeCustomerIdOnSubscriptions < ActiveRecord::Migration[5.2]
  def change
    change_table :subscriptions do |t|
      t.change :customer_id, :bigint
    end
  end
end
