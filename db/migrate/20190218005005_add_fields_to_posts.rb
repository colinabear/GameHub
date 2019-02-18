class AddFieldsToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :author, :string
    add_column :posts, :score, :integer
    add_column :posts, :team_members, :string
  end
end
