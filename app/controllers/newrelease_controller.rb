class NewreleaseController < ConsumerController
  helper ApplicationHelper
  layout 'newIndex'
  def index
    @movies = Movie.find(:all, :order => "releasedate DESC", :limit => 10)  
    @categories = Category.find(:all, :order => "category ASC" )
  end  
  
  def index_new
    #@movies = Movie.find(:all, :order => "releasedate DESC", :limit => 10)  
    @movies = Releaseorder.find (:all, :joins => "left join movies on releaseorders.movie_id = movies.id", :select => "releaseorders.*, movies.title, movies.synopsis, movies.postersmall, movies.postermed, movies.id", :order => "order_list ASC", :limit => 12)
    
    @movies.map {|mov|
	class << mov
    		attr_accessor :truncated
                attr_accessor :categories
  	end
        #remove DIV tag from synopsis
        str = mov.synopsis
        if str =~ /<div[^>]*>/
            str.gsub!(/<div[^>]*>/, "")
            str.gsub!(/<\/div[^>]*>/, "")
            mov.truncated = true
        else 
            mov.truncated = false
        end
        mov.synopsis = str
        limit = "";
        mov.categories = Movie.find_by_sql ["SELECT c.* FROM categories c, categories_movies cm WHERE cm.movie_id = ? AND cm.category_id = c.id ORDER BY c.id ASC "+limit,mov.id]
        mov
    }
    #@categories = Category.find(:all, :order => "category ASC" )
    @banners = Banner.find(:all)
    @banners.map {|b|
        class << b
                attr_accessor :trailer
        end
        @movie = Movie.find(b.movie_id)
        b.trailer = @movie[:trailer]
        b
    }

  end

end
