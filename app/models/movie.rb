class Movie < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :synopsis
  
  has_and_belongs_to_many :categories, 
    :delete_sql => 'DELETE FROM categories_movies WHERE movie_id = #{id}'

  has_and_belongs_to_many :festivals,
    :delete_sql => 'DELETE FROM festivals_movies WHERE movie_id = #{id}'

  def Movie.catsearch(id,page,perpage,options={})
    # options sort should be "title" or "release"
    defaults = {
        :sort => "title",
    }
    options = defaults.merge(options)
    limit = "";
    if(page!=nil && perpage != nil)
      limit = "LIMIT "+( page.to_i != 0 ? (page.to_i * perpage.to_i) : page ).to_s+","+perpage.to_s
    end  

    if (options[:sort] == 'title')
        sort = 'm.title ASC'
    else
        sort = 'm.releasedate DESC'
    end
    
    if (id == nil || id == '0')
        movies = Movie.find_by_sql ["SELECT m.* FROM movies m ORDER BY "+sort+" "+limit]
    else
        movies = Movie.find_by_sql ["SELECT m.* FROM movies m, categories_movies cm WHERE cm.category_id = ? AND cm.movie_id = m.id ORDER BY "+sort+" "+limit,id]
    end

    return movies    
  end
    

  def Movie.moviecats(id)
        movies = Movie.find_by_sql ["SELECT c.category, cm.* FROM movies m, categories_movies cm, categories c WHERE cm.movie_id = m.id AND m.id = ? AND c.id = cm.category_id",id]
    return movies    
  end
end
