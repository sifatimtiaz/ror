class Banners < ActiveRecord::Migration
  def self.up
    # banners table
    create_table( :banners, {:id=>true,:null=>false,:options=>"ENGINE=MyISAM"} ) do |t|
      t.column :movie_id,     :integer, :null => false
      t.column :imagename,    :string, :limit => 150, :null => false
    end
  end

  def self.down
  end
end
