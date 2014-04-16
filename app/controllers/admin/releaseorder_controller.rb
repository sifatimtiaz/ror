class Admin::ReleaseorderController < Admin::AdminController

def index
    # list
    show
    render :action => 'show'
  end
  
  def add
    @releaseorder = Releaseorder.new(params[:releaseorder])
        @releaseorder.movie_id = params[:id]
        @releaseorder.order_list = '5'
        @releaseorder.active = '1'
        @releaseorder.save
    redirect_to :action => 'show'
  end
  
  def destroy
    Releaseorder.find(params[:id]).destroy
    redirect_to :action => 'show'
  end 
  
  @categories = Category.find(:all,:order => "category ASC")
  @releaseorders = Releaseorder.find(:all,:order => "movie_id ASC")
  
  def list
    @releaseorder_pages, @releaseorders = paginate :companyprofiles, :per_page => 10
  end

  def show
    @releaseorders = Releaseorder.find (:all, :joins => "left join movies on releaseorders.movie_id = movies.id", :select => "releaseorders.*, movies.title")
    @movies = Movie.find(:all,:order => "title")
  end
  
#shit from movies controller
def new
    @movie = Movie.new
  end

def create
    @movie = Movie.new(params[:movie])

      if( params[:categories] != nil )
        for ap in params[:categories]
          @movie.categories << Category.find(ap)
        end
      end

      uploadfile(params[:imagelarge],@movie,"posterlarge","pics_movies",false,true)
      uploadfile(params[:imagelarge],@movie,"postersmall","pics_movies",true,true)
      
    if @movie.save
      flash[:notice] = 'Movie was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @releaseorder = Releaseorder.find(params[:id])
  end
  
  def edit_order
    @releaseorder = Releaseorder.find(params[:id])
    @movies = Movie.find(:all,:order => "title")
  end

  def update_order 
    
    releaseorder = Releaseorder.find(params[:id])
    releaseorder.update_attribute(:order_list, params[:order_list])
    #releaseorder.save
    #@releaseorder.order_list = params[:releaseorder]["order_list"]
    #@releaseorder = Releaseorder.find(params[:id])
    #@releaseorder = Releaseorder.find(params[:id])
    #Releaseorder.update_order(params[:releaseorder])
     
      
      redirect_to :action => 'show'
    end
    
 end
  

