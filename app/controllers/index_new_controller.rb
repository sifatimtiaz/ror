class IndexNewController < ConsumerController
  helper ApplicationHelper
  layout 'newIndex'
  def index
    @onload = "n = new Scroller();\n n.init(n,'newsdata','newscontainer');"
    @onloadpress = "n = newpress Scroller();\n n.init(n,'newsdata','newscontainer');"
    @festivals = Festival.find(:all, :order => "festivaldate ASC", :limit => 2)
    @newreleases = Movie.find(:all, :order => "releasedate DESC", :limit => 12)
    page = 'Mainline Releasing'


    if true
      # Get releases, can have more than 3.
      @newmovieorders = Releaseorder.find :all, :joins => "left join movies on releaseorders.movie_id = movies.id", :select => "releaseorders.*, movies.title, movies.synopsis, movies.postersmall, movies.postermed, movies.id", :order => "order_list ASC", :limit => 12
    else
      # Just for now.
      @newmovieorders = Movie.find :all, :order => "releasedate DESC", :limit => 20
    end


    @banners = Banner.find(:all)
    @banners.map {|b|
        class << b
                attr_accessor :trailer
        end
        @movie = Movie.find(b.movie_id)
        b.trailer = @movie[:trailer]
        b
    }

    #limit news
    $news = $news[0..2]
  end
  def scroll
    @onload = "n = new Scroller();\n n.init(n,'newsdata','newscontainer');" 
  end
  def roll
    
  end
end
