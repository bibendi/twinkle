class AddRoleIdOnUsers < ActiveRecord::Migration
  def change
    add_column :users, :role_id, :integer, null: false, default: 0
  end
end
