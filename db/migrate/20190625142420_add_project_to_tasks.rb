class AddProjectToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :project_id, :integer
    add_index :tasks, :project_id
  end
end
