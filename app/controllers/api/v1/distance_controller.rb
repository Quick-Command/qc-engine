class Api::V1::DistanceController < DistanceErrorController
  def index
    distance = DistanceFacade.get_distance(origin, destination)
    return error("Invalid locations. Please enter both city and state for both origin and destination.") if DistanceFacade.invalid_origin?(params) && DistanceFacade.invalid_destination?(params)
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
