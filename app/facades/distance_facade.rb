class DistanceFacade
  def self.get_distance(origin, destination)
    distance = WeatherService.fetch_distance(origin, destination)
    Distance.new(distance)
  end
end
