class AddReviewedTag < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :reviewed, :boolean, :default => false
  end
end
