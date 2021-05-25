class IncidentContactInfo
  attr_reader :id, :title, :name, :email, :phone_number, :distance_miles, :distance_minutes, :city, :state

  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:title]
    @name = attributes[:name]
    @email = attributes[:email]
    @phone_number = attributes[:phone_number]
    @incident_location = attributes[:incident_location]
    @contact_location = attributes[:contact_location]
    @distance_miles = calculate_distance_miles
    @distance_minutes = calculate_distance_minutes
  end

  def calculate_distance_miles
    #@incident_location - @contact_location
    # [*1..100].sample.to_s
    distance = DistanceFacade.get_distance(@incident_location, @contact_location )
    distance.distance_in_miles.to_s
  end

  def calculate_distance_minutes
    #@incident_location - @contact_location
    # [*1..100].sample.to_s
    distance = DistanceFacade.get_distance(@incident_location, @contact_location )
    drive_time_in_minutes = (distance.drive_time.split[0].to_i * 60) + distance.drive_time.split[2].to_i
    drive_time_in_minutes.to_s
  end

  def city
    @contact_location.split.first.delete(",")
  end

  def state
    @contact_location.split.last
  end

end
