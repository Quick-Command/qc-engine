class WeatherService
  def self.weather_connection
    @weather_connection ||= Faraday.new({
      url: ENV['WEATHER_MICROSERVICE_URL']
    })
  end

  def self.fetch_weather(location)
    response = weather_connection.get("/api/v1/forecast_data?location=#{location}")

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.fetch_distance(origin, destination)
    response = weather_connection.get("/api/v1/distance?origin=#{origin}&destination=#{destination}")

    JSON.parse(response.body, symbolize_names: true)
  end
end
