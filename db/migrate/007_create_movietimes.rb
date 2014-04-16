class CreateMovietimes < ActiveRecord::Migration
  def self.up
   create_table :movietimes do |t|
     t.column :movie_id,        :integer, :null => false
     t.column :festival_id,    :integer, :null => false
     t.column :date,         :string, :limit => 60
     t.column :time,         :string, :limit => 20
     t.column :location,     :string, :limit => 120
     t.column :map,         :string, :limit => 200
    end
  end

  def self.down
    drop_table :movietimes
  end
end