class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :amount
      t.float :price
      t.text :comment
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
