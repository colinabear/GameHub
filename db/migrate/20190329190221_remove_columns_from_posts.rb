class RemoveColumnsFromPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :team_members, :string
  end
end
