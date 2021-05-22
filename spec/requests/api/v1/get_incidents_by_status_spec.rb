require 'rails_helper'

RSpec.describe "Incident by Status" do
  describe "Get list of incidents that are active" do
    it "happy path" do
      create_list(:incident, 10, close_date: "", active: true)

      get "/api/v1/incidents?active=true"
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(result).to be_a(Hash)
      expect(result[:data]).to be_an(Array)
      expect(result[:data].first).to be_a(Hash)
      expect(result[:data].first.keys).to eq([:id, :type, :attributes])
      expect(result[:data].first[:type]).to eq("incident")
      expect(result[:data].first[:attributes]).to be_a(Hash)
      expect(result[:data].first[:attributes].keys).to eq([:name, :active, :incident_type, :description, :start_date, :close_date, :location, :city, :state])
      expect(result[:data].first[:attributes][:active]).to eq(true)
      expect(result[:data].first[:attributes][:close_date]).to eq(nil)
    end
    it "sad path" do
      create_list(:incident, 10, active: false)

      get "/api/v1/incidents?active=true"
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(result).to be_a(Hash)
      expect(result[:data]).to be_an(Array)
      expect(result[:data].length).to eq(0)
    end
    it "edge case" do
      create_list(:incident, 10, active: false)

      get "/api/v1/incidents?active=qjfsdnsd"
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(result).to be_a(Hash)
      expect(result[:data]).to be_an(Array)
      expect(result[:data].length).to eq(0)
    end
  end
  describe "Get list of incidents that are not active" do
    it "happy path" do
      create_list(:incident, 10, active: false)

      get "/api/v1/incidents?active=false"
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(result).to be_a(Hash)
      expect(result[:data]).to be_an(Array)
      expect(result[:data].first).to be_a(Hash)
      expect(result[:data].first.keys).to eq([:id, :type, :attributes])
      expect(result[:data].first[:type]).to eq("incident")
      expect(result[:data].first[:attributes]).to be_a(Hash)
      expect(result[:data].first[:attributes].keys).to eq([:name, :active, :incident_type, :description, :start_date, :close_date, :location, :city, :state])
      expect(result[:data].first[:attributes][:active]).to eq(false)
      expect(result[:data].first[:attributes][:close_date].length).to be > 0
    end
    it "sad path" do
      create_list(:incident, 10, active: true)

      get "/api/v1/incidents?active=false"
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(result).to be_a(Hash)
      expect(result[:data]).to be_an(Array)
      expect(result[:data].length).to eq(0)
    end
    it "edge case" do
      create_list(:incident, 10, active: false)

      get "/api/v1/incidents?active=qjfsdnsd"
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(result).to be_a(Hash)
      expect(result[:data]).to be_an(Array)
      expect(result[:data].length).to eq(0)
    end
  end
end
