class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :date, :sunrise, :sunset, :min_temp,
             :max_temp, :humidity, :wind_speed,
             :wind_deg, :wind_gust, :conditions, :precipitation

  set_id { nil }
end
