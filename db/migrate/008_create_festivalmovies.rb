class CreateFestivalmovies < ActiveRecord::Migration
  def self.up
   create_table :festivalmovies do |t|
     t.column :movie_id,        :integer, :null => false
     t.column :festival_id,    :integer, :null => false
    end
  end

  def self.down
    drop_table :festivalmovies
  end
end