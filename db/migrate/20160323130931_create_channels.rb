class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.boolean :active, null: false, default: true
      t.timestamps
    end

    add_index :channels, [:user_id, :name], unique: true
    
    add_foreign_key :channels, :users, on_delete: :cascade
  end
end
