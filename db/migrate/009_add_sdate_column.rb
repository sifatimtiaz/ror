class AddSdateColumn < ActiveRecord::Migration
  def self.up
    add_column  :preleases, :sdate, :string, :limit => 60
  end

  def self.down
    remove_column :preleases, :sdate
  end
end