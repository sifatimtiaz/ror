class FestivalController < ConsumerController
layout 'newIndex'
  
  def index
  
    @festivals = Festival.find(:all, :order => "festivaldate DESC", :limit => 5)  
    #@onload = "n = new Scroller();\n n.init(n,'newsdata','newscontainer');"
    
    # do we need some movies ?
    if( @festivals.size == 0 )
      @newreleases = Movie.find(:all, :order => "releasedate DESC", :limit => 4)
    end
    
    
  end

  def view

    @festival = Festival.find(:all, :conditions => "id = '#{params[:id]}'")
    @onload = "n = new Scroller();\n n.init(n,'newsdata','newscontainer');"
    @movietimes = Movietime.find(:all, :joins => "left join movies on movietimes.movie_id = movies.id", :select => "movietimes.*, movies.*", :conditions => "festival_id = '#{params[:id]}'", :order => "movies.title DESC")
    @festout = Festivalmovie.find (:all, :joins => "left join movies on festivalmovies.movie_id = movies.id", :select => "festivalmovies.*, movies.title, movies.postersmall", :conditions => "festival_id = '#{params[:id]}'")
    #@selectmovies = Festivalmovie.find (:all, :joins => "left join movies on festivalmovies.movie_id = movies.id left join movietimes on festivalmovies.festival_id", :select => "festivalmovies.*, movietimes.*, movies.title, movies.synopsis, movies.postersmall", :conditions => "festivalmovies.festival_id = '#{params[:id]}'")
    #@selecttimes = Movietime.find (:all, :conditions => "festival_id = '#{params[:id]}'")
    #@showtimes = Movietime.find(:all, :joins => "left join festivalmovies on movietimes.festival_id = festivalmovies.festival_id", :select => "movietimes.*, festivalmovies.*", :conditions => "festival_id = '#{params[:id]}'", :order => "movies.title DESC")
    
  end
end
