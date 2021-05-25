class DistanceSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes :origin, :destination, :distance_in_miles, :drive_time
end
