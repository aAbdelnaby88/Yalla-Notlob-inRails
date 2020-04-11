class AddImageUrlToOrdesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :img_url , :string
  end
end
