class Forecast
  attr_reader :date,
              :sunrise,
              :sunset,
              :min_temp,
              :max_temp,
              :humidity,
              :wind_speed,
              :wind_deg,
              :wind_gust,
              :conditions,
              :precipitation

  def initialize(data)
    @date = data[:data][:attributes][:daily_weather].first[:date]
    @sunrise = data[:data][:attributes][:daily_weather].first[:sunrise]
    @sunset = data[:data][:attributes][:daily_weather].first[:sunset]
    @min_temp = data[:data][:attributes][:daily_weather].first[:min_temp]
    @max_temp = data[:data][:attributes][:daily_weather].first[:max_temp]
    @humidity = data[:data][:attributes][:daily_weather].first[:humidity]
    @wind_speed = data[:data][:attributes][:daily_weather].first[:wind_speed]
    @wind_deg = data[:data][:attributes][:daily_weather].first[:wind_deg]
    @wind_gust = data[:data][:attributes][:daily_weather].first[:wind_gust]
    @conditions = data[:data][:attributes][:daily_weather].first[:conditions]
    @precipitation = data[:data][:attributes][:daily_weather].first[:precipitation]
  end
end
