class Festival < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :description
  
  has_many :festivalmovies
  has_and_belongs_to_many :movies,
    :delete_sql => 'DELETE FROM festivals_movies WHERE festival_id = #{id}'
 end 
  
  class Festivalmovie < ActiveRecord::Base
    has_and_belongs_to_many :festivals
    has_many :movies
  end
  


