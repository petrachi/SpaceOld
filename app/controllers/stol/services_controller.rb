class Stol::ServicesController < Stol::ApplicationController

  def index
    @services = __model__.all
  end

  def show
    @service = __model__.find params[:id]
  end

end
