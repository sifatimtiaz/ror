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

  def create
    @festival = Festival.new(params[:festival])

      uploadfile(params[:thumbfile],@festival,"imagelarge","pics_festivals",false,true)
      uploadfile(params[:thumbfile],@festival,"imagesmall","pics_festivals",true,true)
    
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
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @festival = Festival.find(params[:id])
  end

  def update
    @festival = Festival.find(params[:id])
    
      uploadfile(params[:thumbfile],@festival,"imagelarge","pics_festivals",false,true)
      uploadfile(params[:thumbfile],@festival,"imagesmall","pics_festivals",true,true)
      
#    if(params[:thumbfile] && params[:thumbfile] != "")
#      if( params[:thumbfile].original_filename != "" )
#      logger.debug("FILE NAME: " + params[:thumbfile].original_filename)
#       File.open("#{RAILS_ROOT}/public/images/pics_festivals/"+params[:thumbfile].original_filename,"wb") { |f| f.write(params[:thumbfile].read) }
#       @festival.imagesmall = params[:thumbfile].original_filename
#      end
#    end        
    
    @festival.title = params[:festival]["title"]
    @festival.subtitle = params[:festival]["subtitle"]
    @festival.shortdesc = params[:festival]["shortdesc"]
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
