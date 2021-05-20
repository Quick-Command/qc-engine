require 'rails_helper'

RSpec.describe "Update an incident" do
  describe "happy path" do
    it "can update an incident" do
      incident = create(:incident, active: true, name: "Jim Creeks Fire", incident_type: "Fire", description: "5th alarm fire", location: "Denver, CO", start_date: "2020-05-01", close_date: "")
      incident_params = {name: "Denver Zoo Fire"}

      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/incidents/#{incident.id}", headers: headers, params: JSON.generate(incident_params)

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
end
