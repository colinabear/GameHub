class EditPendingUsersInTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :pending_users, :integer, array: true, default: []
    add_column :tasks, :pending_users, :text
  end
end
