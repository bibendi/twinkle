class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :username, null: false
      t.string :remember_token, null: false
      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
    add_index :users, :remember_token, unique: true
  end
end
