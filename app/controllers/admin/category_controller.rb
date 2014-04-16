class Admin::CategoryController < Admin::AdminController
  #layout 'admin/movie'
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
         
  @category_pages, @categories = paginate :categories, :per_page => 30, :order_by => 'category'  

  def list
    # @category_pages, @categories = paginate :categories, :per_page => 30, :order_by => 'category'
    @form_action = 'create'
    @form_id = ''
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to :action => 'list'
    else
     # render :action => 'new'     
     @form_action = 'create'
     render :action => 'list'
    end
  end

  def edit
    # @category_pages, @categories = paginate :categories, :per_page => 30      
    @category = Category.find(params[:id])
    @form_action = 'update'
    @form_id = @category
    render :action => 'list'
  end

  def update
    # @category_pages, @categories = paginate :categories, :per_page => 30    
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = 'Category was successfully updated.'
      # redirect_to :action => 'show', :id => @category
      redirect_to :action => 'list'
    else
     #  render :action => 'edit'
     @form_action = 'update'
     render :action => 'list'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
