class Api::V1::ForecastController < ForecastErrorController
  def index
    weather = ForecastFacade.get_forecast(location)
    return error("Invalid location. Please enter both city and state.") if ForecastFacade.invalid_location?(params)

    render json: ForecastSerializer.new(weather)
  end

  private

  def location
    params[:location]
  end
end
