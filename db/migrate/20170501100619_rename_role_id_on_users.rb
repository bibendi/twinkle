class RenameRoleIdOnUsers < ActiveRecord::Migration
  def up
    execute "alter table users alter column role_id drop default"
    return if Rails.env.test?
    execute "update users set role_id = 10 where role_id = 0"
    execute "update users set role_id = 20 where role_id = 1"
  end

  def down
    execute "alter table users alter column role_id set default 0"
    return if Rails.env.test?
    execute "update users set role_id = 0 where role_id = 10"
    execute "update users set role_id = 1 where role_id = 20"
  end
end
