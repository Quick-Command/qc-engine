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
end
