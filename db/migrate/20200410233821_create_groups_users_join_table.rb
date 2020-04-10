class CreateGroupsUsersJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :groups, :users
  end
end
