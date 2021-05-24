require 'rails_helper'

RSpec.describe Forecast do
  it 'exists and has attributes' do
    data = {
            "data": {
            "attributes": {
            "daily_weather": [
                                {
                                  "date": "2021-05-20",
                                  "sunrise": "2021-05-20 06:41:01 -0500",
                                  "sunset": "2021-05-20 21:12:15 -0500",
                                  "min_temp": 53.15,
                                  "max_temp": 80.29,
                                  "humidity": 22,
                                  "wind_speed": 17.58,
                                  "wind_deg": 151,
                                  "wind_gust": 23.4,
                                  "conditions": "scattered clouds",
                                  "precipitation": 0.2
                                }
                              ]
                            }
                          }
                        }

    forecast_data = Forecast.new(data)

    expect(forecast_data).to be_a(Forecast)
    expect(forecast_data.date).to be_a(String)
    expect(forecast_data.sunrise).to be_a(String)
    expect(forecast_data.sunset).to be_a(String)
    expect(forecast_data.min_temp).to be_a(Numeric)
    expect(forecast_data.max_temp).to be_a(Numeric)
    expect(forecast_data.humidity).to be_a(Numeric)
    expect(forecast_data.wind_speed).to be_a(Numeric)
    expect(forecast_data.wind_deg).to be_a(Numeric)
    expect(forecast_data.wind_gust).to be_a(Numeric)
    expect(forecast_data.conditions).to be_a(String)
    expect(forecast_data.precipitation).to be_a(Numeric)
  end
end
