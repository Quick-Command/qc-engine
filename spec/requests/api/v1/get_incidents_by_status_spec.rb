require 'rails_helper'

RSpec.describe "Incident by Status" do
  describe "Get list of incidents that are open" do
    it "happy path" do
      create_list(:incident, 10, active: true)

      get "/api/v1/incidents?active=true"
      result = JSON.parse(response.body, symbolize_names: true)
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(result).to be_a(Hash)
      expect(result[:data]).to be_an(Array)
      expect(result[:data].first).to be_a(Hash)
      expect(result[:data].first.keys).to eq([:id, :type, :attributes])
      expect(result[:data].first[:type]).to eq("incident")
      expect(result[:data].first[:attributes]).to be_a(Hash)
      expect(result[:data].first[:attributes].keys).to eq([:name, :incident_type, :active, :description, :location, :start_date, :closed_date])
      expect(result[:data].first[:attributes][:active]).to eq("true")
      expect(result[:data].first[:attributes][:close_date].count).to be_greater_than(0)
    end
  end
end
