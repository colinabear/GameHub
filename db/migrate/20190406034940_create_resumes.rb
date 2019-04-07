class CreateResumes < ActiveRecord::Migration[5.1]
  def change
    create_table :resumes do |t|
      t.string :email
      t.string :phone_number
      t.string :location
      t.timestamps
    end
  end
end
