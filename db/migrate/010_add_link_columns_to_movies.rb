class AddLinkColumnsToMovies < ActiveRecord::Migration
  def self.up
    add_column  :movies, :link2, :string
  end

  def self.down
    remove_column :movies, :link2
  end
end
