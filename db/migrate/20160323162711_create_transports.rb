class CreateTransports < ActiveRecord::Migration
  def change
    execute "CREATE TYPE transport_type AS ENUM ('Transports::Telegram')"

    create_table :transports do |t|
      t.column :type, :transport_type, null: false
      t.integer :user_id, null: false
      t.jsonb :data, null: false, default: '{}'
      t.timestamps
    end

    add_index :transports, [:user_id, :type]

    add_foreign_key :transports, :users, on_delete: :cascade
  end
end
