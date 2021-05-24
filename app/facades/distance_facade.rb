class DistanceFacade
  def self.get_distance(origin, destination)
    distance = WeatherService.fetch_distance(origin, destination)
    Distance.new(distance)
  end

  def self.invalid_origin?(params)
    return true if params[:origin].nil?

    city, state = params[:origin].split(',')
    params[:origin] == '' || city.blank? || state.blank?
  end

  def self.invalid_destination?(params)
    return true if params[:destination].nil?

    city, state = params[:destination].split(',')
    params[:destination] == '' || city.blank? || state.blank?
  end
end
