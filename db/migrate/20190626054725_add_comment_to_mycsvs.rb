class AddCommentToMycsvs < ActiveRecord::Migration[5.2]
  def change
    add_column :mycsvs, :comment_id, :integer
    add_index :mycsvs, :comment_id
  end
end
