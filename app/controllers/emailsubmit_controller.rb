class EmailsubmitController < ApplicationController

  # global submit email query
  def dosubmit
    # lazy submit
    if(params[:id] != nil && params[:id] != "")
      @email = Email.new
      @email.address = params[:id]
      @email.submitted = Time.now()
      @email.save
    end
    render :text => "ok";
  end
    
end
