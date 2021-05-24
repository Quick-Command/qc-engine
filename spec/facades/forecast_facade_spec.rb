require 'rails_helper'

RSpec.describe 'Forecast Facade' do
  describe 'happy path' do
    it 'can get the forecast for a city and state search' do
      VCR.use_cassette('denver_forecast_data') do
        location = 'Denver, CO'
        forecast = ForecastFacade.get_forecast(location)

        expect(forecast).to be_a(Forecast)
      end
    end
  end
end
