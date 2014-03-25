class Stol::RubiesController < Stol::ServicesController
  def get_location
    @section = :rubies
    super
  end

  def __model__
    Stol::Ruby
  end
end
