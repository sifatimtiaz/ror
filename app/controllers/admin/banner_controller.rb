class Admin::BannerController < Admin::AdminController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @banner_pages, @banners = paginate :banners, :per_page => 10
  end

  def show
    @banner = Banner.find(params[:id])
  end

  def new
    @banner = Banner.new
  end

  def create
    @banner = Banner.new(params[:banner])
    # @banner[:movie_id] = params[:movie_id]
    uploadfile(params[:image],@banner,"imagename","pics_banners",false,false,false)
    
    if @banner.save
      flash[:notice] = 'Banner was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @banner = Banner.find(params[:id])
  end

  def update
    @banner = Banner.find(params[:id])
    # @banner[:movie_id] = params[:movie_id]
    if(params[:image] != "")
      uploadfile(params[:image],@banner,"imagename","pics_banners",false,false,false)
    end
    
    if @banner.update_attributes(params[:banner])
    # if @banner.save
      flash[:notice] = 'Banner was successfully updated.'
      redirect_to :action => 'show', :id => @banner
    else
      render :action => 'edit'
    end
  end

  def destroy
    Banner.find(params[:id]).destroy
    redirect_to :action => 'list'
  end  
  
end
