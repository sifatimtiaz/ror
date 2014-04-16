class AboutController < ConsumerController
  helper ApplicationHelper
  layout 'newIndex'
  def index
    @about = Companyprofile.find(1)
    #@onload = "n = new Scroller();\n n.init(n,'newsdata','newscontainer');"
    $news = $news[0..2]
  end
  
  def question
    @about = Companyprofile.find(1)
    @question = Question.new(params[:question])
    @question.submitted = Time.now()
      if(@question.save)
        emailQuestion(@question)
        flash[:notice] = 'Question was successfully created'
        redirect_to :action => 'qsubmit'
      else
        render :action => 'index'
      end
  end
  
  def qsubmit
    @about = Companyprofile.find(1)
  end
  
end
