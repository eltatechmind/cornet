class RemoveTitleFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :title, :string
  end
end
