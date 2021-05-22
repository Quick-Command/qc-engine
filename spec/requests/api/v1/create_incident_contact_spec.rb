require 'rails_helper'

RSpec.describe 'Create an Incident Contact Endpoint' do
  describe 'post request to add a contact to an incident with a specific title/role' do
    describe 'happy path' do
      it 'can add a contact to an incident with a specific role' do
        incident = create(:incident, active: true)
        contact = create(:contact, job_title: "Safety Officer")
        incident_contact_params = ({ title: "Safety Officer" })

        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/incidents/#{incident.id}/contacts/#{contact.id}", headers: headers, params: JSON.generate(incident_contact_params)

        result = JSON.parse(response.body, symbolize_names: true)
        incident_contact_1 = IncidentContact.last

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(result).to be_a(Hash)
        expect(result[:data]).to be_a(Hash)
        expect(result[:data].count).to eq(3)
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:id]).to be_a(String)
        expect(result[:data][:id]).to eq(contact.id.to_s)
        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to eq("incident_contact")
        expect(result[:data]).to have_key(:attributes)
        expect(result[:data][:attributes]).to be_a(Hash)
        expect(result[:data][:attributes].count).to eq(8)
        expect(result[:data][:attributes]).to have_key(:title)
        expect(result[:data][:attributes][:title]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:distance_miles)
        expect(result[:data][:attributes][:distance_miles]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:distance_minutes)
        expect(result[:data][:attributes][:distance_minutes]).to be_a(String)
      end
    end
    describe 'sad path' do
      it 'cannot add a contact to an incident if there is no title' do
        incident = create(:incident, active: true)
        contact = create(:contact, job_title: "Safety Officer")
        incident_contact_params = ({ title: "" })

        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/incidents/#{incident.id}/contacts/#{contact.id}", headers: headers, params: JSON.generate(incident_contact_params)

        result = JSON.parse(response.body, symbolize_names: true)
        incident_contact_1 = IncidentContact.last

        error = JSON.parse(response.body, symbolize_names: true)
        error_message = "Title must be assigned"

        expect(response).to have_http_status(400)
        expect(error).to have_key(:error)
        expect(error[:error]).to eq("#{error_message}")
      end
      it 'cannot add a contact to an incident if the incident does not exist' do
        contact = create(:contact, job_title: "Safety Officer")
        incident_contact_params = ({ title: "" })

        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/incidents/12387123897129/contacts/#{contact.id}", headers: headers, params: JSON.generate(incident_contact_params)

        error = JSON.parse(response.body, symbolize_names: true)
        error_message = "Incident does not exist"

        expect(response).to have_http_status(404)
        expect(error).to have_key(:error)
        expect(error[:error]).to eq("#{error_message}")
      end
      it 'cannot add a contact to an incident if the contact does not exist' do
        incident = create(:incident, active: true)
        incident_contact_params = ({ title: "Safety Officer" })

        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/incidents/#{incident.id}/contacts/7812348971239", headers: headers, params: JSON.generate(incident_contact_params)

        error = JSON.parse(response.body, symbolize_names: true)
        error_message = "Contact does not exist"

        expect(response).to have_http_status(404)
        expect(error).to have_key(:error)
        expect(error[:error]).to eq("#{error_message}")
      end
    end
  end
end
