class Admin::RegistrationController < Admin::AdminController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @registration_pages, @registrations = paginate :registrations, :per_page => 10
  end

  def show
    @registration = Registration.find(params[:id])
  end

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(params[:registration])
    if @registration.save
      flash[:notice] = 'Registration was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @registration = Registration.find(params[:id])
  end

  def update
    @registration = Registration.find(params[:id])
    if @registration.update_attributes(params[:registration])
      flash[:notice] = 'Registration was successfully updated.'
      redirect_to :action => 'show', :id => @registration
    else
      render :action => 'edit'
    end
  end

  def destroy
    Registration.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
