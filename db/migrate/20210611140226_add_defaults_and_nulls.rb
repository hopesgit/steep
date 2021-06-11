class AddDefaultsAndNulls < ActiveRecord::Migration[5.2]
  def change
    change_column_null :customers, :first_name, false
    change_column_null :customers, :last_name, false
    change_column_null :customers, :email, false
    change_column_null :customers, :address, false
    change_column_null :teas, :title, false
    change_column_null :teas, :description, false
    change_column_null :teas, :brew_time, false
    change_column_null :teas, :api_id, false
    change_column_default :subscriptions, :status, 0
  end
end
