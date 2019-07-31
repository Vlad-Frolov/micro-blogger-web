# frozen_string_literal: true

class CreateBlogs < ActiveRecord::Migration[5.2]
  def change
    create_table :blogs do |t|
      t.string :title, null: false
      t.text :article, null: false
      t.string :published_date, null: false, default: ""
      t.integer :user_id

      t.timestamps
    end
    add_index :blogs, :user_id
  end
end
