class IndexController < ConsumerController

  def index
  
    #@newreleases = Movie.find(:all, :order => "releasedate DESC", :limit => 4)
    #@festivals = Festival.find(:all, :order => "festivaldate ASC", :limit => 4)
    #@onload = "n = new Scroller();\n n.init(n,'newsdata','newscontainer');" 
    #@newmovieorders = Releaseorder.find (:all, :joins => "left join movies on releaseorders.movie_id = movies.id", :select => "releaseorders.*, movies.title, movies.synopsis, movies.postersmall, movies.id", :order => "order_list ASC", :limit => 4)
     
    redirect_to_url ("http://www.lightningentertainmentgroup.com/")
  end
  
  def indexTest
  
    @newreleases = Movie.find(:all, :order => "releasedate DESC", :limit => 4)
    @festivals = Festival.find(:all, :order => "festivaldate ASC", :limit => 4)
    @onload = "n = new Scroller();\n n.init(n,'newsdata','newscontainer');" 
    @newmovieorders = Releaseorder.find (:all, :joins => "left join movies on releaseorders.movie_id = movies.id", :select => "releaseorders.*, movies.title, movies.synopsis, movies.postersmall, movies.id", :order => "order_list ASC", :limit => 4)
    
  end
  
  def descript
    
  end
  
  # rss feed for the news output
  def newsrss
    # already have global $news = News.returnNews
    render_without_layout
    @headers["Content-Type"] = "application/xml; charset=utf-8"   

  end
end
