require 'rails_helper'

RSpec.describe "Incident Details" do
  describe "Get an incident's details" do
    it "happy path" do
      incident = create(:incident, active: true, close_date: "")

      get "/api/v1/incidents/#{incident.id}"
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(result).to be_a(Hash)
      expect(result[:data]).to be_a(Hash)
      expect(result[:data].keys).to eq([:id, :type, :attributes])
      expect(result[:data][:type]).to eq("incident")
      expect(result[:data][:attributes]).to be_a(Hash)
      expect(result[:data][:attributes].keys).to eq([:name, :active, :incident_type, :description, :location, :start_date, :close_date])
      expect(result[:data][:attributes][:active]).to eq(true)
      expect(result[:data][:attributes][:close_date]).to eq(nil)
    end
    it "sad path" do
      incident = create(:incident, active: true)

      get "/api/v1/incidents/#{incident.id + 1}"
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(result).to be_a(Hash)
      expect(result[:error]).to eq("Incident does not exist with that id")
    end
    it "edge case" do
      incident = create(:incident, active: true)

      get "/api/v1/incidents/ashjdnvajhnv"
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(result).to be_a(Hash)
      expect(result[:error]).to eq("Incident does not exist with that id")
    end
  end
end
