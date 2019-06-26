class AddUserToMycsvs < ActiveRecord::Migration[5.2]
  def change
    add_column :mycsvs, :user_id, :integer
    add_index :mycsvs, :user_id
  end
end
