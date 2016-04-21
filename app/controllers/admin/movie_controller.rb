require 'RMagick'
class Admin::MovieController < Admin::AdminController 
  #layout 'admin/movie'
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  
  @categories = Category.find(:all,:order => "category ASC")
  
  def list
    # @movie_pages, @movies = paginate (:movies, :order => 'title', :per_page => 20)
    @movies = Movie.find(:all,:order => "title")
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end
  
  def nav
    render :action => 'nav'
  end

  def create
    @movie = Movie.new(params[:movie])

      if( params[:categories] != nil )
        for ap in params[:categories]
          @movie.categories << Category.find(ap)
        end
      end

      uploadfile(params[:imagelarge],@movie,"posterlarge","pics_movies",false,true,false)
      uploadfile(params[:imagelarge],@movie,"postersmall","pics_movies",true,true,false)
      uploadfile(params[:imagelarge],@movie,"postermed","pics_movies/med",false,true,true)
      
    if @movie.save
      flash[:notice] = 'Movie was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if(params[:imagelarge] == "")
      updated = @movie.update_attributes(params[:movie])
      #if( params[:categories] != nil )
      #  for ap in params[:categories]
      #    @movie.categories << Category.find(ap)
      #  end
      #end      
    else
    
      uploadfile(params[:imagelarge],@movie,"posterlarge","pics_movies",false,true,false)
      uploadfile(params[:imagelarge],@movie,"postersmall","pics_movies",true,true,false)
      uploadfile(params[:imagelarge],@movie,"postermed","pics_movies/med",false,true,true)
      
      @movie.title = params[:movie]["title"]
      @movie.synopsis = params[:movie]["synopsis"]
      @movie.cast = params[:movie]["cast"]
      @movie.director = params[:movie]["director"]
      @movie.link = params[:movie]["link"]
      @movie.link2 = params[:movie]["link2"]
      @movie.link3 = params[:movie]["link3"]
      @movie.screener = params[:movie]["screener"]
      @movie.trailer = params[:movie]["trailer"]
      @movie.releasedate = params[:movie]["releasedate(1i)"]+"-"+params[:movie]["releasedate(2i)"]+"-"+params[:movie]["releasedate(3i)"] # params[:movie]["releasedate"]
      @movie.length = params[:movie]["length"]
      
      if( params[:categories] != nil )
      # delete former categories
      for c in @movie.categories
        @movie.categories.delete(c)
      end
        for ap in params[:categories]
          @movie.categories << Category.find(ap)
        end
      end
      updated = @movie.save
    end
    
    if updated
      flash[:notice] = 'Movie was successfully updated.'
      redirect_to :action => 'show', :id => @movie
    else
      render :action => 'edit'
    end
  end

  def destroy
    Movie.find(params[:id]).destroy
    redirect_to :action => 'list'
  end  
  
end
