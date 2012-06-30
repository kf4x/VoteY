class AddingUsername < ActiveRecord::Migration
  def up
    add_column :users, :username, :string
    rename_column :users, :password, :encrypted_password
    rename_column :users, :password_confirmation, :salt
    add_index :users, :username
  end

  def down
    drop_column :users, :username
    rename_column :users, :encrypted_password, :password
    rename_column :users, :salt, :password_confirmation
    remove_index :users, :username
  end
end