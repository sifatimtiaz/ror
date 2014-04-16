class Releaseorders < ActiveRecord::Migration
  def self.up
    create_table "releaseorders",:force => true do |t|
    t.column "movie_id", :integer, :default => 0, :null => false
    t.column "order_list", :integer, :default => 0, :null => false
    t.column "active", :integer, :default => 1, :null => false
  end
    
  end

  def self.down
   drop_table :releaseorders
  end
end
