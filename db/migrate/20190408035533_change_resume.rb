class ChangeResume < ActiveRecord::Migration[5.1]
  def change
    remove_column :resumes, :email, :string
    add_column :resumes, :name, :string
    add_column :resumes, :biography, :text
  end
end
