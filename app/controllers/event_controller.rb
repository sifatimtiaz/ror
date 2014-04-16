class EventController < ConsumerController
layout 'newSections'
  def index
    @events = Event.find(:all, :order => "eventdate DESC", :limit => 10)
    @onload = "n = new Scroller();\n n.init(n,'newsdata','newscontainer');"    
    
    # do we need some movies ?
    if( @events.size == 0 )
      @newreleases = Movie.find(:all, :order => "releasedate DESC", :limit => 4)
    end
    
  end

  def view
    @event = Event.find(params[:id])
    @onload = "n = new Scroller();\n n.init(n,'newsdata','newscontainer');"    
  end
  
  def register
    @event = Event.find(params[:registration][:event_id])  
    @registration = Registration.new(params[:registration])
      if(@registration.save)
        flash[:notice] = 'Registration was successfully created'
        redirect_to :action => 'view', :id => params[:registration][:event_id]
      else
        render :action => 'view', :id => params[:registration][:event_id]
      end
  end
  
end
