class CreatePreleases < ActiveRecord::Migration
  def self.up
    create_table :preleases do |t|
      t.column :title,          :string, :limit => 100
      t.column :body,           :text
      t.column :stitle,         :string, :limit => 100
      t.column :subtitle,       :string, :limit => 100
      t.column :byline,         :string, :limit => 100
      t.column :sbody,          :text
      t.column :date,           :date
    end
  end

  def self.down
    drop_table :preleases
  end
end
