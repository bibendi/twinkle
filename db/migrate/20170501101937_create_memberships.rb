class CreateMemberships < ActiveRecord::Migration
  def up
    create_table :client_users do |t|
      t.integer :client_id, null: false
      t.integer :user_id, null: false
      t.integer :role_id, null: false
      t.timestamps null: false
    end

    add_index :client_users, :client_id
    add_index :client_users, [:user_id, :client_id], unique: true

    add_foreign_key :client_users, :clients, on_delete: :cascade
    add_foreign_key :client_users, :users, on_delete: :cascade

    create_table :orgs do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    add_index :orgs, :name, unique: true

    create_table :teams do |t|
      t.integer :org_id, null: false
      t.string :name
      t.timestamps null: false
    end

    add_index :teams, [:org_id, :name], unique: true
    add_foreign_key :teams, :orgs, on_delete: :cascade

    create_table :client_teams do |t|
      t.integer :client_id, null: false
      t.integer :team_id, null: false
      t.integer :role_id, null: false
      t.timestamps null: false
    end

    add_index :client_teams, :client_id
    add_index :client_teams, [:team_id, :client_id], unique: true

    add_foreign_key :client_teams, :clients, on_delete: :cascade
    add_foreign_key :client_teams, :teams, on_delete: :cascade
  end

  def down
    drop_table :client_teams
    drop_table :teams
    drop_table :orgs

    drop_table :client_users
  end
end
