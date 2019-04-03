class RemoveIdsFromTasksAndUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :task_id, :integer
    remove_column :tasks, :user_id, :integer
  end
end
