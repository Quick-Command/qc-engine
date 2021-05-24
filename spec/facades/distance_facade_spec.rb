require 'rails_helper'

RSpec.describe 'Distance Facade' do
  describe 'happy path' do
    it 'can get the forecast for a city and state search' do
      VCR.use_cassette('origin_to_destination') do
        origin = 'Denver, CO'
        destination = 'Miami, FL'
        forecast = DistanceFacade.get_distance(origin, destination)

        expect(forecast).to be_a(Distance)
      end
    end
  end
end
