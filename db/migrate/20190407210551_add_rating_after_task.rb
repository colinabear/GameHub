class AddRatingAfterTask < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :programming_rating, :integer, default: 0
    add_column :users, :art_rating, :integer, default: 0
    add_column :users, :music_rating, :integer, default: 0
    add_column :users, :level_design_rating, :integer, default: 0
    add_column :users, :story_rating, :integer, default: 0
    add_column :users, :puzzles_rating, :integer, default: 0
    add_column :users, :misc_rating, :integer, default: 0
  end
end
