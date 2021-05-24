class Api::V1::ForecastController < ApplicationController
  def index
    return error("Invalid location parameter") if ForecastFacade.invalid_location?(params)
    weather = ForecastFacade.get_forecast(location)

    render json: ForecastSerializer.new(weather)
  end

  private

  def location
    params[:location]
  end
end
