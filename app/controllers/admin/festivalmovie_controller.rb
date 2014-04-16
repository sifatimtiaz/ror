class Admin::FestivalmovieController < Admin::AdminController
def index
  render :action => 'index'
end

def add_movie
        @festivalmovie = Festivalmovie.new(params[:festivalmovie])
        @festivalmovie.movie_id = params[:movie_id]
        @festivalmovie.festival_id = params[:festival_id]
        @festivalmovie.save
    #redirect_to :back
    redirect_to "/admin/festival/last_record?festival_id="+params[:festival_id]
  end
  
 def destroy
   @festivalmovie = Festivalmovie.find(params[:id])
   @festivalmovie.destroy    
    redirect_to :back
 end
end
