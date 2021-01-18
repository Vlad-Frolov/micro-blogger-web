class AddBioToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :bio, :text
  end

  def down
    remove_column :users, :bio
  end
end
