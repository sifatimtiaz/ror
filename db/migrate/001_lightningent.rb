class Lightningent < ActiveRecord::Migration
  def self.up
    self.down
    
    # movies table
    create_table( :movies, {:id=>true,:null=>false,:options=>"ENGINE=MyISAM"} ) do |t|
      t.column :title,          :string, :limit => 100, :null => false
      t.column :synopsis,       :text, :null => false
      t.column :cast,           :text, :null => false
      t.column :director,       :string, :limit => 100, :null => false
      t.column :link,           :string, :limit => 200, :null => true
      t.column :posterlarge,    :string, :null => true
      t.column :postersmall,    :string, :null => true
      t.column :trailer,        :string, :null => true 
      t.column :releasedate,    :date, :null => false
      t.column :length,         :string, :limit => 15, :null => false
    end
    
    # categories table
    create_table( :categories, {:id=>true,:null=>false,:options=>"ENGINE=MyISAM"} ) do |t|
      t.column :category,          :string, :limit => 60, :null => false
      t.column :color,             :string, :limit => 10, :null => false
    end
    
    # genre mapping join table - movie can be assigned to more than one genre
    create_table( :categories_movies, {:id=>false,:options=>"ENGINE=MyISAM"}) do |t|
      t.column :category_id,    :integer, :null => false
      t.column :movie_id,       :integer, :null => false
    end
    
    # festivals 
    create_table( :festivals, {:id=>true,:null=>false,:options=>"ENGINE=MyISAM"}) do |t|
      t.column :title,          :string, :limit => 100, :null => false
      t.column :subtitle,       :string, :null => true 
      t.column :shortdesc,      :string, :null => true 
      t.column :description,    :text, :null => true 
      t.column :imagesmall,     :string, :null => true
      t.column :imagelarge,     :string, :null => true
      t.column :link,           :string, :null => true
      t.column :festivaldate,   :date, :null => false
    end
    
      # festival movies
      create_table( :festivals_movies, {:id=>false,:null=>true,:options=>"ENGINE=MyISAM"}) do |t|
        t.column :movie_id,     :integer, :null => false
        t.column :festival_id,  :integer, :null => false
      end
      
    create_table( :events, {:id=>true,:null=>false,:options=>"ENGINE=MyISAM"}) do |t|
      t.column :title,          :string, :null => false
      t.column :description,    :text, :null => true
      t.column :imagelarge,     :string, :null => true
      t.column :imagesmall,     :string, :null => true
      t.column :eventdate,      :date, :null => false
    end
    
      create_table( :registrations, {:id=>true,:null=>false,:options=>"ENGINE=MyISAM"}) do |t|
        t.column :fullname,     :string, :limit => 100, :null => false
        t.column :company,      :string, :limit => 100, :null => true
        t.column :phone,        :string, :limit => 20, :null => true
        t.column :email,        :string, :limit => 60, :null => false
        t.column :withguest,    :boolean, :default => 0
        t.column :event_id,     :integer, :null => false
      end
      
      create_table( :emails, {:id=>true,:null=>false,:options=>"ENGINE=MyISAM"}) do |t|
        t.column :address,      :string, :limit => 60, :null => false
        t.column :submitted,    :date
      end
      
      create_table( :questions, {:id=>true,:null=>false,:options=>"ENGINE=MyISAM"}) do |t|
        t.column :fullname,   :string, :limit => 100, :null => false
        t.column :address,    :string, :limit => 150
        t.column :city,       :string, :limit => 100
        t.column :state,      :string, :limit => 40
        t.column :zip,        :string, :limit => 15
        t.column :phone,      :string, :limit => 20
        t.column :email,      :string, :limit => 60, :null => false
        t.column :comments,   :text
        t.column :submitted,  :datetime
      end
      
      create_table( :companyprofiles, {:id=>true,:null=>false,:options=>"ENGINE=MyISAM"}) do |t|
        t.column :title,      :string, :null => false
        t.column :synopsis,   :text, :null => false
      end
      
      
    ##############################################################
    # Site administration and users
    # #############################################################

     
    # user administrators
    create_table( :users, {:id=>true,:null=>false,:options=>"ENGINE=MyISAM"}) do |t|
      t.column :username,       :string, :limit => 20, :null => false
      t.column :password,       :string, :limit => 20, :null => false 
      t.column :name,           :string, :limit => 40, :null => false
      t.column :email,          :string, :limit => 60, :null => false
    end
    
    User.new(:username => "admin", :password => "adm1n1st3r", :name => "Bret Orton", :email => "borton@noof.com").save!
    
      # roles 
      create_table( :roles, {:id=>true,:null=>false,:options=>"ENGINE=MyISAM"}) do |t|
        t.column :rolename,         :string, :limit => 30, :null => false
      end
      Role.new(:rolename => "Administrator").save!
      Role.new(:rolename => "Site Maintainer").save!
      
      # roles and users
      create_table( :roles_users, {:id=>false,:null=>true,:options=>"ENGINE=MyISAM"}) do |t|
        t.column :role_id,      :integer, :null => false
        t.column :user_id,      :integer, :null => false
      end
    
  end # end self.up

  def self.down
  end
end
