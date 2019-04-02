class AddProgressToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :progress, :string
  end
end
