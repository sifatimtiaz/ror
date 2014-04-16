class SynopsisController < ConsumerController
  layout 'blank'
  def index
  @syn = Movie.find(params[:id])
  end
  
end