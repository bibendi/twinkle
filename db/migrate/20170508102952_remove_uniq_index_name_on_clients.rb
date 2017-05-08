class RemoveUniqIndexNameOnClients < ActiveRecord::Migration
  def up
    remove_index :clients, :name
  end

  def down
    add_index :clients, :name, unique: true
  end
end
