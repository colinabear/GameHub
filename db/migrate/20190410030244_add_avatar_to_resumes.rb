class AddAvatarToResumes < ActiveRecord::Migration[5.1]
  def change
    add_column :resumes, :avatar, :string
  end
end
