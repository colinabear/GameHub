class EditTeamMemebersInProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :team_members, :string
    add_column :projects, :team_members, :text
  end
end
