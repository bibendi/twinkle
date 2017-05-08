class AddGithubTokenOnUsers < ActiveRecord::Migration
  def up
    add_column :users, :github_token, :string
    execute "update users set github_token = 'random-token-' || id::varchar"
    change_column_null :users, :github_token, false
  end

  def down
    remove_column :users, :github_token
  end
end
