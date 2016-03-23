class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :token, null: false
      t.boolean :active, null: false, default: true
      t.timestamps
    end

    add_index :users, :name, unique: true
    add_index :users, :token, unique: true
  end
end
