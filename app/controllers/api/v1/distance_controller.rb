class Api::V1::DistanceController < DistanceErrorController
  def index
    distance = DistanceFacade.get_distance(origin, destination)

    render json: DistanceSerializer.new(distance)
  end

  private

  def origin
    params[:origin]
  end

  def destination
    params[:destination]
  end
end
