require 'rails_helper'

RSpec.describe 'Get Forecast' do
  describe ' happy path' do
    it 'sends the daily forecast for the given valid location' do
      VCR.use_cassette('daily_forecast_for_location') do
        location = 'denver,co'

        get "/api/v1/forecast?location=#{location}"
        result = JSON.parse(response.body, symbolize_names: true)

        daily = result[:data][:attributes]

        expect(daily).to be_a(Hash)
        expect(daily.keys.count).to eq(11)
        expect(daily).to have_key(:date)
        expect(daily[:date]).to be_a(String)
        expect(daily).to have_key(:sunrise)
        expect(daily[:sunrise]).to be_a(String)
        expect(daily).to have_key(:sunset)
        expect(daily[:sunset]).to be_a(String)
        expect(daily).to have_key(:max_temp)
        expect(daily[:max_temp]).to be_a(Numeric)
        expect(daily).to have_key(:min_temp)
        expect(daily[:min_temp]).to be_a(Numeric)
        expect(daily).to have_key(:humidity)
        expect(daily[:humidity]).to be_a(Numeric)
        expect(daily).to have_key(:wind_speed)
        expect(daily[:wind_speed]).to be_a(Numeric)
        expect(daily).to have_key(:wind_deg)
        expect(daily[:wind_deg]).to be_a(Numeric)
        expect(daily).to have_key(:wind_gust)
        expect(daily[:wind_gust]).to be_a(Numeric)
        expect(daily).to have_key(:conditions)
        expect(daily[:conditions]).to be_a(String)
        expect(daily).to have_key(:precipitation)
        expect(daily[:precipitation]).to be_a(Numeric)

        expect(daily).to_not have_key(:moonrise)
        expect(daily).to_not have_key(:moonset)
        expect(daily).to_not have_key(:feels_like)
        expect(daily).to_not have_key(:pressure)
        expect(daily).to_not have_key(:dew_point)
        expect(daily).to_not have_key(:clouds)
        expect(daily).to_not have_key(:uvi)
      end
    end
  end

  describe 'sad path' do
    it 'returns an error response if user sends an empty string for location' do
      VCR.use_cassette('invalid_location') do
        location = ''
        get "/api/v1/forecast?location=#{location}"

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(result[:error]).to eq("Location does not exist. Please enter valid location.")
      end
    end

    it 'returns an error response if user sends nothing for location' do
      VCR.use_cassette('no_location') do
        get "/api/v1/forecast"

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(result[:error]).to eq("Location does not exist. Please enter valid location.")
      end
    end

    it 'returns an error response if no city is provided within the location' do
      VCR.use_cassette('no_city_in_location') do
        location = 'co'
        get "/api/v1/forecast?location=#{location}"

        result = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(400)
        expect(result[:error]).to eq("Invalid location. Please enter both city and state.")
      end
    end

    it 'returns an error response if no state code is provided within the location' do
      VCR.use_cassette('no_state_code_in_location') do
        location = 'denver'
        get "/api/v1/forecast?location=#{location}"
        result = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(400)
        expect(result[:error]).to eq("Invalid location. Please enter both city and state.")
      end
    end
  end

  describe 'edge case path' do
    it 'returns an error response if the location does not match anything' do
      VCR.use_cassette('crazy_location') do
        location = '[]!!!'
        get "/api/v1/forecast?location=#{location}"

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(result[:error]).to eq("Location does not exist. Please enter valid location.")
      end
    end
  end
end
