class Distance
  attr_reader :origin,
              :destination,
              :drive_time,
              :distance_in_miles


  def initialize(data)
    @origin = data[:data][:attributes][:origin]
    @destination = data[:data][:attributes][:destination]
    @distance_in_miles = data[:data][:attributes][:distance_in_miles]
    @drive_time = data[:data][:attributes][:drive_time]
  end
end
