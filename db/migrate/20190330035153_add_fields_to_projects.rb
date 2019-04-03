class AddFieldsToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :author, :string
    add_column :projects, :team_members, :string
  end
end
