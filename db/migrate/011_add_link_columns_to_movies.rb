class AddLinkColumnsToMovies < ActiveRecord::Migration
  def self.up
    add_column  :movies, :link3, :string
  end

  def self.down
    remove_column :movies, :link3
  end
end
