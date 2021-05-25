require 'rails_helper'

RSpec.describe 'Get Distance' do
  describe ' happy path' do
    it 'sends the distance for the given locations' do
      VCR.use_cassette('denver_to_chicago') do
        origin = 'Denver,CO'
        destination= 'Chicago,IL'

        get "/api/v1/distance?origin=#{origin}&destination=#{destination}"
        result = JSON.parse(response.body, symbolize_names: true)

        distance = result[:data][:attributes]

        expect(distance).to be_a(Hash)
        expect(distance.keys.count).to eq(4)
        expect(distance[:origin]).to be_a(String)
        expect(distance[:destination]).to be_a(String)
        expect(distance[:distance_in_miles]).to be_a(Numeric)
        expect(distance[:drive_time]).to be_a(String)
      end
    end
  end

  describe 'sad path' do
    it 'returns an error response if user sends an empty string for locations' do
      VCR.use_cassette('invalid_orgin_and_destination') do
        origin = ''
        destination = ''
        get "/api/v1/distance?origin=#{origin}&destination=#{destination}"

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(result[:error]).to eq("Locations does not exist. Please enter valid locations.")
      end
    end

    it 'returns an error response if user sends nothing for locations' do
      VCR.use_cassette('no_distance_locations') do
        get "/api/v1/distance"

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(result[:error]).to eq("Locations does not exist. Please enter valid locations.")
      end
    end

    it 'returns an error response if no city is provided within the locations' do
      VCR.use_cassette('no_cities_in_origin_and_destination') do
        origin = 'CO'
        destination = 'IL'
        get "/api/v1/distance?origin=#{origin}&destination=#{destination}"

        result = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(400)
        expect(result[:error]).to eq("Invalid locations. Please enter both city and state for both origin and destination.")
      end
    end

    it 'returns an error response if no state code is provided within the locations' do
      VCR.use_cassette('no_state_code_in_origin_and_destination') do
        origin = 'Denver'
        destination = 'Chicago'
        get "/api/v1/distance?origin=#{origin}&destination=#{destination}"
        # binding.pry
        result = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(400)
        expect(result[:error]).to eq("Invalid locations. Please enter both city and state for both origin and destination.")
      end
    end
  end

  describe 'edge case path' do
    it 'returns an error response if the locations do not match anything' do
      VCR.use_cassette('crazy_distance_locations') do
        origin = '[]'
        destination = '[]'
        get "/api/v1/distance?origin=#{origin}&destination=#{destination}"

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(400)
        expect(result[:error]).to eq("Locations does not exist. Please enter valid locations.")
      end
    end
  end
end
