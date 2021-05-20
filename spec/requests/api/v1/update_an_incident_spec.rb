require 'rails_helper'

RSpec.describe "Update an incident" do
  describe "happy path" do
    it "can update an incident" do
      incident = create(:incident, active: true, name: "Jim Creeks Fire", incident_type: "Fire", description: "5th alarm fire", location: "Denver, CO", start_date: "2020-05-01", close_date: "")
      incident_params = {name: "Denver Zoo Fire"}

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/incidents/#{incident.id}", headers: headers, params: JSON.generate(incident_params)
      result = JSON.parse(response.body, symbolize_names: true)
      incident = Incident.find(incident.id)

      expect(response).to be_successful
      expect(incident.name).to eq(incident_params[:name])
      expect(incident.active).to eq(true)
      expect(incident.description).to eq(incident[:description])
      expect(incident.incident_type).to eq(incident[:incident_type])
      expect(incident.start_date).to eq(incident[:start_date])
      expect(incident.close_date).to eq(nil)
    end
  end
  describe "sad path" do
    it "can't update an incident with blank name" do
      incident = create(:incident, active: true, name: "Jim Creeks Fire", incident_type: "Fire", description: "5th alarm fire", location: "Denver, CO", start_date: "2020-05-01", close_date: "")
      incident_params = {name: ""}

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/incidents/#{incident.id}", headers: headers, params: JSON.generate(incident_params)
      result = JSON.parse(response.body, symbolize_names: true)
      incident = Incident.find(incident.id)

      expect(result).to be_a(Hash)
      expect(result[:error]).to eq("Incident name cannot be blank.")
    end
    it "can't update an incident with blank incident type" do
      incident = create(:incident, active: true, name: "Jim Creeks Fire", incident_type: "Fire", description: "5th alarm fire", location: "Denver, CO", start_date: "2020-05-01", close_date: "")
      incident_params = {incident_type: ""}

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/incidents/#{incident.id}", headers: headers, params: JSON.generate(incident_params)
      result = JSON.parse(response.body, symbolize_names: true)
      incident = Incident.find(incident.id)

      expect(result).to be_a(Hash)
      expect(result[:error]).to eq("Incident type cannot be blank.")
    end
    it "can't update an incident with blank location" do
      incident = create(:incident, active: true, name: "Jim Creeks Fire", incident_type: "Fire", description: "5th alarm fire", location: "Denver, CO", start_date: "2020-05-01", close_date: "")
      incident_params = {location: ""}

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/incidents/#{incident.id}", headers: headers, params: JSON.generate(incident_params)
      result = JSON.parse(response.body, symbolize_names: true)
      incident = Incident.find(incident.id)

      expect(result).to be_a(Hash)
      expect(result[:error]).to eq("Incident location cannot be blank.")
    end
    it "can't update an incident with blank start_date" do
      incident = create(:incident, active: true, name: "Jim Creeks Fire", incident_type: "Fire", description: "5th alarm fire", location: "Denver, CO", start_date: "2020-05-01", close_date: "")
      incident_params = {start_date: ""}

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/incidents/#{incident.id}", headers: headers, params: JSON.generate(incident_params)
      result = JSON.parse(response.body, symbolize_names: true)
      incident = Incident.find(incident.id)

      expect(result).to be_a(Hash)
      expect(result[:error]).to eq("Incident start date cannot be blank.")
    end
    it "can't update an incident with blank close_date if active = false" do
      incident = create(:incident, active: false, name: "Jim Creeks Fire", incident_type: "Fire", description: "5th alarm fire", location: "Denver, CO", start_date: "2020-05-01", close_date: "2020-05-03")
      incident_params = {close_date: ""}

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/incidents/#{incident.id}", headers: headers, params: JSON.generate(incident_params)
      result = JSON.parse(response.body, symbolize_names: true)
      incident = Incident.find(incident.id)

      expect(result).to be_a(Hash)
      expect(result[:error]).to eq("An inactive incident needs a close date")
    end
    it "can't update an incident that does not exist" do
      incident = create(:incident, active: false, name: "Jim Creeks Fire", incident_type: "Fire", description: "5th alarm fire", location: "Denver, CO", start_date: "2020-05-01", close_date: "2020-05-03")
      incident_params = {close_date: ""}

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/incidents/123874538913457", headers: headers, params: JSON.generate(incident_params)
      result = JSON.parse(response.body, symbolize_names: true)
      incident = Incident.find(incident.id)

      expect(result).to be_a(Hash)
      expect(result[:error]).to eq("Incident does not exist with that id")
    end
  end
  describe "edge case" do
    it "can't update an incident that does not exist" do
      incident = create(:incident, active: false, name: "Jim Creeks Fire", incident_type: "Fire", description: "5th alarm fire", location: "Denver, CO", start_date: "2020-05-01", close_date: "2020-05-03")
      incident_params = {close_date: ""}

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/incidents/&&&", headers: headers, params: JSON.generate(incident_params)
      result = JSON.parse(response.body, symbolize_names: true)
      incident = Incident.find(incident.id)

      expect(result).to be_a(Hash)
      expect(result[:error]).to eq("Incident does not exist with that id")
    end
  end
end
