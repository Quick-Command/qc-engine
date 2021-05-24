class ForecastFacade
  def self.get_forecast(location)
    weather = WeatherService.fetch_weather(location)
    Forecast.new(weather)
  end

  def self.invalid_location?(params)
    return true if params[:location].nil?

    city, state = params[:location].split(',')
    params[:location] == '' || city.blank? || state.blank?
  end
end
