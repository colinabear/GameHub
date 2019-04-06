class AddPendingUsersToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :pending_users, :integer, array: true, default: []
  end
end
