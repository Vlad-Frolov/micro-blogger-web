# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string  :display_name,    null: false
      t.string  :email,           null: false
      t.string  :password_digest, null: false
      t.integer :role,            null: false, default: 0

      t.timestamps
    end
    add_index :users, :email
  end
end
