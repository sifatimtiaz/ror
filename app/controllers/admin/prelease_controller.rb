class Admin::PreleaseController < Admin::AdminController
  def index
    list
    render :action => 'list'
  end
  
  def list
    @preleases = Prelease.find(:all, :order => "id DESC")
  end
  
  def edit
    @prelease = Prelease.find(params[:id])
  end
  
  def new
    @prelease = Prelease.new
  end
  
  def show
    @preleases = Prelease.find(params[:id])
  end
  
  def create
    @prelease = Prelease.new(params[:prelease])
    @prelease.date = Date.today
    
    if @prelease.save
      flash[:notice] = 'Press Release was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end
  
  def update
    @prelease = Prelease.find(params[:id])
    
    if @prelease.update_attributes(params[:prelease])
    # if @prelease.save
      flash[:notice] = 'Press Release was successfully updated.'
      redirect_to :action => 'list', :id => @prelease
    else
      render :action => 'edit'
    end
  end

  def destroy
    Prelease.find(params[:id]).destroy
    redirect_to :action => 'list'
  end  

  
end
