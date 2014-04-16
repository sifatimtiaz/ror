class Admin::CompanyprofileController < Admin::AdminController
  def index
    # list
    show
    render :action => 'show'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @companyprofile_pages, @companyprofiles = paginate :companyprofiles, :per_page => 10
  end

  def show
    @companyprofile = Companyprofile.find(1)#Companyprofile.find(params[:id])
  end

  def new
    @companyprofile = Companyprofile.new
  end

  def create
    @companyprofile = Companyprofile.new(params[:companyprofile])
    if @companyprofile.save
      flash[:notice] = 'Companyprofile was successfully created.'
      redirect_to :action => 'show', :id => @companyprofile
    else
      render :action => 'new'
    end
  end

  def edit
    @companyprofile = Companyprofile.find(params[:id])
  end

  def update
    @companyprofile = Companyprofile.find(params[:id])
    if @companyprofile.update_attributes(params[:companyprofile])
      flash[:notice] = 'Companyprofile was successfully updated.'
      redirect_to :action => 'show', :id => @companyprofile
    else
      render :action => 'edit'
    end
  end

  def destroy
    Companyprofile.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
