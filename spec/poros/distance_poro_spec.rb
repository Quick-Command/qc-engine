require 'rails_helper'

RSpec.describe Forecast do
  it 'exists and has attributes' do
    data = {
            "data": {
            "attributes": {
                                {
                                  "origin": "Denver,CO",
                                  "destination": "Chicago,IL",
                                  "distance_in_miles": 1300,
                                  "drive_time": "18 hours, 24 minutes away."
                                }
                            }
                          }
                        }

    distance_data = Distance.new(data)

    expect(distance_data).to be_a(Distance)
    expect(distance_data.origin).to be_a(String)
    expect(distance_data.destination).to be_a(String)
    expect(distance_data.distance_in_miles).to be_a(Numeric)
    expect(distance_data.drive_time).to be_a(String)
  end
end
