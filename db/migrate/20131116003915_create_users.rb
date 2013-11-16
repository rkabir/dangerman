class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid
      t.string  :username
      t.string  :password
      t.string  :password_hint
    end

    add_index :users, :username, :unique => true
    add_index :users, :password
    add_index :users, :password_hint
  end
end
