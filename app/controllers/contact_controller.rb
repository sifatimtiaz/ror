class ContactController < ConsumerController
    helper ApplicationHelper
    layout 'newIndex'
    def index
        #@onload = "n = new Scroller();\n n.init(n,'newsdata','newscontainer');"
      
        @contacts = Contact.find(:all,:order=>"id ASC")
        $news = $news[0..2]
    end
  
  
    def question
      @question = Question.new(params[:question])
      @question.submitted = Time.now()
      @contacts = Contact.find(:all,:order=>"id ASC")
        if(@question.save)
          emailQuestion(@question)
          flash[:notice] = 'Question was successfully created'
          redirect_to :action => 'index'
        else
          render :action => 'index'
        end
    end

end
