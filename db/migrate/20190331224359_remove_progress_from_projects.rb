class RemoveProgressFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :progress, :integer
  end
end
