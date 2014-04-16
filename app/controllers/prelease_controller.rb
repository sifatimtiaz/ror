class PreleaseController < ConsumerController
layout 'newIndex'
helper ApplicationHelper
def index
    @perpage = 20
    @page = 0;
    @count = 0;
      if(params[:pg] != nil && params[:page] != "" )
        @page = params[:pg]
      end
    @count = Prelease.count_by_sql("SELECT COUNT(*) FROM preleases")

    limit = ( @page.to_i != 0 ? (@page.to_i * @perpage.to_i) : @page ).to_s+","+@perpage.to_s

    @preleases = Prelease.find(:all, :order => "id DESC", :limit => limit)  
    #@onload = "n = new Scroller();\n n.init(n,'newsdata','newscontainer');"
    
  end

  def view
    @preleases = Prelease.find(params[:id])

    #@onload = "n = new Scroller();\n n.init(n,'newsdata','newscontainer');"
  end
end
