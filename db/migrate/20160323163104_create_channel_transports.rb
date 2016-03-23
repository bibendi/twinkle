class CreateChannelTransports < ActiveRecord::Migration
  def change
    create_table :channel_transports do |t|
      t.integer :channel_id, null: false
      t.integer :transport_id, null: false
      t.timestamps
    end

    add_index :channel_transports, [:channel_id, :transport_id], unique: true
    add_index :channel_transports, :transport_id

    add_foreign_key :channel_transports, :channels, on_delete: :cascade
    add_foreign_key :channel_transports, :transports, on_delete: :cascade
  end
end
