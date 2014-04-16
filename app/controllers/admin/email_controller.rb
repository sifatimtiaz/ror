class Admin::EmailController < Admin::AdminController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update, :search ],
         :redirect_to => { :action => :list }

  @email_pages, @emails = paginate :emails, :per_page => 50, :order_by => :address
  @search_results = ''
  
  def list
   # @email_pages, @emails = paginate :emails, :per_page => 10
    @form_action = 'create'
    @form_id = ''
  end

  def show
    @email = Email.find(params[:id])
  end

  def search
    # @email_pages, @emails = Email.find_by_sql["SELECT * FROM emails WHERE address LIKE '%?%'",params['search']]
    @search = Email.find_by_sql("SELECT * FROM emails WHERE address like '%"+params['search']+"%'")
    if(@search != nil && @search.size > 0)
      @emails = @search
    else
      @search_results = '<br/>No results for ' + params['search']
    end
    render :action => 'list'
  end
  
  def new
    @email = Email.new
  end

  def create
    @email = Email.new(params[:email])
    if @email.save
      flash[:notice] = 'Email was successfully created.'
      redirect_to :action => 'list'
    else
     # render :action => 'new'
     @form_action = 'create'
     @form_id = @email
     render :action => 'list'
    end
  end

  def edit
    @email = Email.find(params[:id])
    @form_action = 'update'
    @form_id = @email
    render :action => 'list'
  end

  def update
    @email = Email.find(params[:id])
    if @email.update_attributes(params[:email])
      flash[:notice] = 'Email was successfully updated.'
     # redirect_to :action => 'show', :id => @email
     redirect_to :action => 'list'
    else
      # render :action => 'edit'
      @form_action = 'update'
      @form_id = @email
      render :action => 'list'
    end
  end

  def destroy
    Email.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
