class AddCachedVotesToProjects < ActiveRecord::Migration[5.1]
  def self.up
    add_column :projects, :cached_votes_total, :integer, :default => 0
    add_column :projects, :cached_votes_score, :integer, :default => 0
    add_column :projects, :cached_votes_up, :integer, :default => 0
    add_column :projects, :cached_votes_down, :integer, :default => 0
    add_column :projects, :cached_weighted_score, :integer, :default => 0
    add_column :projects, :cached_weighted_total, :integer, :default => 0
    add_column :projects, :cached_weighted_average, :float, :default => 0.0
    add_index  :projects, :cached_votes_total
    add_index  :projects, :cached_votes_score
    add_index  :projects, :cached_votes_up
    add_index  :projects, :cached_votes_down
    add_index  :projects, :cached_weighted_score
    add_index  :projects, :cached_weighted_total
    add_index  :projects, :cached_weighted_average

    Project.find_each(&:update_cached_votes)
  end
end
