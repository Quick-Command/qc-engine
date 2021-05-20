require 'rails_helper'

RSpec.describe WeatherService do
  describe 'happy path' do
    it 'fetches weather data for a given location' do
      VCR.use_cassette("weather_service_data") do
        location = 'Denver,CO'
        response = WeatherService.fetch_weather(location)

        expect(response).to be_a(Hash)
        expect(response).to have_key(:data)
        expect(response[:data]).to be_a(Hash)
        expect(response[:data].keys).to eq([:id, :type, :attributes])
        expect(response[:data][:id]).to eq(nil)
        expect(response[:data][:type]).to be_a(String)
        expect(response[:data][:type]).to eq('forecast')
        expect(response[:data][:attributes]).to be_a(Hash)
        expect(response[:data][:attributes]).to have_key(:daily_weather)
        expect(response[:data][:attributes][:daily_weather]).to be_an(Array)
        expect(response[:data][:attributes][:daily_weather].first).to be_a(Hash)
        expect(response[:data][:attributes][:daily_weather].first.keys).to eq([:date, :sunrise, :sunset,
                                                                                 :min_temp, :max_temp, :humidity,
                                                                                 :wind_speed, :wind_deg, :wind_gust,
                                                                                 :conditions, :precipitation
                                                                                ])
        expect(response[:data][:attributes][:daily_weather].first[:date]).to be_a(String)
        expect(response[:data][:attributes][:daily_weather].first[:sunrise]).to be_a(String)
        expect(response[:data][:attributes][:daily_weather].first[:sunset]).to be_a(String)
        expect(response[:data][:attributes][:daily_weather].first[:min_temp]).to be_a(Numeric)
        expect(response[:data][:attributes][:daily_weather].first[:max_temp]).to be_a(Numeric)
        expect(response[:data][:attributes][:daily_weather].first[:humidity]).to be_a(Numeric)
        expect(response[:data][:attributes][:daily_weather].first[:wind_speed]).to be_a(Numeric)
        expect(response[:data][:attributes][:daily_weather].first[:wind_deg]).to be_a(Numeric)
        expect(response[:data][:attributes][:daily_weather].first[:wind_gust]).to be_a(Numeric)
        expect(response[:data][:attributes][:daily_weather].first[:conditions]).to be_a(String)
        expect(response[:data][:attributes][:daily_weather].first[:precipitation]).to be_a(Numeric)
      end
    end

    it 'can test the data structure of the API data received from the call' do
      VCR.use_cassette("weather_service_data") do
        location = 'Denver,CO'
        response = WeatherService.fetch_weather(location)

        expect(response[:data][:attributes][:daily_weather].first[:date]).to eq("2021-05-20")
        expect(response[:data][:attributes][:daily_weather].first[:sunrise]).to eq("2021-05-20 06:41:01 -0500")
        expect(response[:data][:attributes][:daily_weather].first[:sunset]).to eq("2021-05-20 21:12:15 -0500")
        expect(response[:data][:attributes][:daily_weather].first[:min_temp]).to eq(53.15)
        expect(response[:data][:attributes][:daily_weather].first[:max_temp]).to eq(79.65)
        expect(response[:data][:attributes][:daily_weather].first[:humidity]).to eq(22)
        expect(response[:data][:attributes][:daily_weather].first[:wind_speed]).to eq(17.58)
        expect(response[:data][:attributes][:daily_weather].first[:wind_deg]).to eq(151)
        expect(response[:data][:attributes][:daily_weather].first[:wind_gust]).to eq(23.4)
        expect(response[:data][:attributes][:daily_weather].first[:conditions]).to eq("scattered clouds")
        expect(response[:data][:attributes][:daily_weather].first[:preciptation]).to eq(nil)
      end
    end
  end
end
