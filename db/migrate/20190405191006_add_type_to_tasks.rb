class AddTypeToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :job_type, :string
  end
end
