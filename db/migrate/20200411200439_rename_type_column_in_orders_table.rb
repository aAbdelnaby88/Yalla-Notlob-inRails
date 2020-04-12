class RenameTypeColumnInOrdersTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :type, :meal

  end
end
