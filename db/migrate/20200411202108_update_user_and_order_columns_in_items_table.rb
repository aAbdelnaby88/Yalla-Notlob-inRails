class UpdateUserAndOrderColumnsInItemsTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :order_id
    remove_column :items, :user_id
    add_reference :items, :order_user, foreign_key: true
  end
end
