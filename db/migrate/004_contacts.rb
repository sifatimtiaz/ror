class Contacts < ActiveRecord::Migration
  def self.up
  
    # contacts
    create_table( :contacts, {:id=>true, :null=>false, :options=>"ENGINE=MyISAM"} ) do |t|
      t.column :name,          :string, :limit => 100, :null => false
      t.column :email,         :string, :limit => 100, :null => false
      t.column :title,         :string, :limit => 100, :null => false
    end
  
  
  end

  def self.down
  
  end
end
