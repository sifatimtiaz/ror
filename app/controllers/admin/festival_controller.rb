require 'RMagick'
class Admin::FestivalController < Admin::AdminController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @festival_pages, @festivals = paginate :festivals, :per_page => 10
  end

  def show
    @festival = Festival.find(params[:id])
  end

  def new
    @festival = Festival.new
  end
  
  def add_movie
    @film = Film.new(params[:film])
        @film.movie_id = params[:id]
        @film.order_list = '5'
        @film.active = '1'
        @film.save
    redirect_to :action => 'show'
  end

  def create
    @festival = Festival.new(params[:festival])

      uploadfile(params[:thumbfile],@festival,"imagelarge","pics_festivals",false,true,false)
      uploadfile(params[:thumbfile],@festival,"imagesmall","pics_festivals",true,true,false)
    
    # check for movies
    if (params[:movies] != nil)
      for fm in params[:movies]
        @festival.movies << Movie.find(fm)
      end
    end    
#    if(params[:thumbfile] && params[:thumbfile] != "")
#      if( params[:thumbfile].original_filename != "" )
#      logger.debug("FILE NAME: " + params[:thumbfile].original_filename)
#       File.open("#{RAILS_ROOT}/public/images/pics_festivals/"+params[:thumbfile].original_filename,"wb") { |f| f.write(params[:thumbfile].read) }
#       @festival.imagesmall = params[:thumbfile].original_filename
#      end
#    end    
    
    if @festival.save
      flash[:notice] = 'Festival was successfully created.'
      #redirect_to '/admin/festival/last_record?festival_id=#{params[:id]}'
      redirect_to :action => 'new_fest'
     # redirect_to "/admin/festival/last_record?festival_id="+params[:movietime]["festival_id"]
    else
      render :action => 'new'
    end
  end
  
  def last_record
     @festivals = Festival.find (:all, :order => "id DESC", :limit => 1)
     @movies = Movie.find(:all,:order => "title")
     #@festivalmovies = Festivalmovie.find(:all,:order => "id")
     @festivalmovies = Festivalmovie.find (:all, :joins => "left join movies on festivalmovies.movie_id = movies.id", :select => "festivalmovies.*, movies.title", :conditions => "festival_id = '#{params[:festival_id]}'")
     @movietimes = Movietime.find(:all, :joins => "left join movies on movietimes.movie_id = movies.id", :select => "movietimes.*, movies.title", :conditions => "festival_id = '#{params[:festival_id]}'", :order => "movies.title DESC")
     @festout = Festivalmovie.find (:all, :joins => "left join movies on festivalmovies.movie_id = movies.id", :select => "festivalmovies.*, movies.title, movies.postersmall", :conditions => "festival_id = '#{params[:festival_id]}'")
  end
  
  def new_fest
    @festivals = Festival.find (:all, :order => "id DESC", :limit => 1)
    @movies = Movie.find(:all,:order => "title")
    #redirect_to "/admin/festival/last_record?festival_id="+@festivals.id
    @movietimes = Movietime.find(:all, :joins => "left join movies on movietimes.movie_id = movies.id", :select => "movietimes.*, movies.title", :conditions => "festival_id = festival_id", :order => "movies.title DESC")
    @festout = Festivalmovie.find (:all, :joins => "left join movies on festivalmovies.movie_id = movies.id", :select => "festivalmovies.*, movies.title, movies.postersmall", :conditions => "festival_id = 'festivalmovies.festival_id'")
  end

  def edit
    @festival = Festival.find(params[:id])
  end

  def update
    @festival = Festival.find(params[:id])
    
      uploadfile(params[:thumbfile],@festival,"imagelarge","pics_festivals",false,true,false)
      uploadfile(params[:thumbfile],@festival,"imagesmall","pics_festivals",true,true,false)
      
#    if(params[:thumbfile] && params[:thumbfile] != "")
#      if( params[:thumbfile].original_filename != "" )
#      logger.debug("FILE NAME: " + params[:thumbfile].original_filename)
#       File.open("#{RAILS_ROOT}/public/images/pics_festivals/"+params[:thumbfile].original_filename,"wb") { |f| f.write(params[:thumbfile].read) }
#       @festival.imagesmall = params[:thumbfile].original_filename
#      end
#    end        
    
    @festival.title = params[:festival]["title"]
    @festival.subtitle = params[:festival]["subtitle"]
    #@festival.shortdesc = params[:festival]["shortdesc"]
    @festival.description = params[:festival]["description"]
    @festival.link = params[:festival]["link"]
    @festival.festivaldate = params[:festival]["festivaldate(1i)"]+"-"+params[:festival]["festivaldate(2i)"]+"-"+params[:festival]["festivaldate(3i)"]
    
    # check for movies
    if (params[:movies] != nil)
      for m in @festival.movies
        @festival.movies.delete(m)
      end
      for fm in params[:movies]
        @festival.movies << Movie.find(fm)
      end
    end
    
#    if @festival.update_attributes(params[:festival])
     if @festival.save    
      flash[:notice] = 'Festival was successfully updated.'
      redirect_to :action => 'show', :id => @festival
    else
      render :action => 'edit'
    end
  end

  def destroy
    # Festival.find(params[:id]).destroy
    @festival = Festival.find(params[:id])
    if( @festival[:imagesmall] != "" )
      File.delete("#{RAILS_ROOT}/public/images/pics_festivals/"+@festival[:imagesmall])
      File.delete("#{RAILS_ROOT}/public/images/pics_festivals/"+@festival[:imagelarge])
    end
    @festival.destroy    
    redirect_to :action => 'list'
  end 
  
  
end
