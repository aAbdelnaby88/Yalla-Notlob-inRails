class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :friend_a
      t.references :friend_b

      t.timestamps
    end
  end
end
