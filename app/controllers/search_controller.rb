class SearchController < ConsumerController
layout 'newIndex'
  def index
  
    @onload = "n = new Scroller();\n n.init(n,'newsdata','newscontainer');"
      
    # pagination variables
    @perpage = 10
    @page = 0;
    @count = 0;
    
    @errors = "";
    @search = nil
    if(params[:query] != nil && params[:query] != "" )
    
      if(params[:pg] != nil && params[:page] != "" )
        @page = params[:pg]
      end
      
      @count = Search.results(params[:query],nil,nil).size
      @search = Search.results(params[:query],@page,@perpage)

      
    else
      @errors = "Please provide search text."
    end
    
  end
  
  
#    def paginate_from_sql(model, sql, count_sql, per_page)
#      plural_model_name = "@#{model.name.underscore.pluralize}".to_sym
#      paginator_name = "@#{model.name.underscore}_pages".to_sym
#      self.instance_variable_set(paginator_name, Paginator.new(self, model.count_by_sql(count_sql), per_page, @params['page']))
#      self.instance_variable_set(plural_model_name, model.find_by_sql(sql + " LIMIT #{per_page}" + " OFFSET #{self.instance_variable_get(paginator_name).current.to_sql[1]}"))
#    end
#    
end
