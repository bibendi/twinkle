class RenameUsersToClients < ActiveRecord::Migration
  def change
    rename_table :users, :clients

    rename_column :channels, :user_id, :client_id
    rename_column :transports, :user_id, :client_id
  end
end
