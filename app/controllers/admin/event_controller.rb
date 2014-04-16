class Admin::EventController < Admin::AdminController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @event_pages, @events = paginate :events, :per_page => 10
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
  
    @event = Event.new(params[:event])
    
      uploadfile(params[:thumbfile],@event,"imagelarge","pics_events",false,true)
      uploadfile(params[:thumbfile],@event,"imagesmall","pics_events",true,true)
          
    if @event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
  
    @event = Event.find(params[:id])
    
      uploadfile(params[:thumbfile],@event,"imagelarge","pics_events",false,true)
      uploadfile(params[:thumbfile],@event,"imagesmall","pics_events",true,true)

    
    @event.title = params[:event]["title"]
    @event.description = params[:event]["description"]
    @event.eventdate = params[:event]["eventdate(1i)"]+"-"+params[:event]["eventdate(2i)"]+"-"+params[:event]["eventdate(3i)"]    
    
    #if @event.update_attributes(params[:event])
    if @event.save
      flash[:notice] = 'Event was successfully updated.'
      redirect_to :action => 'show', :id => @event
    else
      render :action => 'edit'
    end
  end

  def destroy
    # Event.find(params[:id]).destroy
    @event = Event.find(params[:id])
    if( @event[:imagelarge] != "" )
      File.delete("#{RAILS_ROOT}/public/images/pics_events/"+@event[:imagelarge])
      File.delete("#{RAILS_ROOT}/public/images/pics_events/"+@event[:imagesmall])
    end
    @event.destroy
    redirect_to :action => 'list'
  end 
  
  
end # end class
