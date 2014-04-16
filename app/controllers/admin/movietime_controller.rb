class Admin::MovietimeController < Admin::AdminController
def index
  render :action => 'index'
end

def destroy
   @movietime = Movietime.find(params[:id])
   @movietime.destroy  
    redirect_to :back
 end

def new
    @movietime = Movietime.new
    @movies = Movie.find(:all,:conditions => "id = '#{params[:movie_id]}'")
  end
  
 def create
    @movietime = Movietime.new(params[:movietime])
    @movietime.save
    redirect_to "/admin/festival/last_record?festival_id="+params[:movietime]["festival_id"]
 end
 
 def edit
    @movietime = Movietime.find(params[:id])
    @movies = Movie.find(:all,:conditions => "id = '#{params[:movie_id]}'")
  end
  
  def update
    @movietime = Movietime.find(params[:id])
    @movietime.date = params[:movietime]["date"]
    @movietime.time = params[:movietime]["time"]
    @movietime.location = params[:movietime]["location"]
    @movietime.map = params[:movietime]["map"]
    @movietime.save
    redirect_to "/admin/festival/last_record?festival_id="+params[:movietime]["festival_id"]
    end

end
