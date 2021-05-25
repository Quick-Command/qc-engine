require 'rails_helper'

RSpec.describe 'Update an Incident Contact Endpoint' do
  describe 'patch request to add a contact to an incident with a specific title/role and delete the old contact from the title' do
    describe 'happy path' do
      it 'can add a contact to an incident with a specific role' do
        role_1 = create(:role, title: "Incident Commander")
        role_2 = create(:role, title: "Safety Officer")
        role_3 = create(:role, title: "Fire Marshall")
        incident = create(:incident)
        incident_2 = create(:incident)
        contact_1 = create(:contact, job_title: "Incident Commander")
        contact_2 = create(:contact, job_title: "Incident Commander")
        contact_3 = create(:contact, job_title: "Incident Commander")
        contact_4 = create(:contact, job_title: "Safety Officer")
        contact_5 = create(:contact, job_title: "Safety Officer")
        contact_1.roles << role_1
        contact_2.roles << role_1
        contact_3.roles << role_1
        contact_4.roles << role_2
        contact_5.roles << role_3
        ic = IncidentContact.create({incident_id: incident.id, contact_id: contact_3.id, title: "Incident Commander"})
        ic2 = IncidentContact.create({incident_id: incident.id, contact_id: contact_4.id, title: "Safety Officer"})
        ic3 = IncidentContact.create({incident_id: incident.id, contact_id: contact_5.id, title: "Fire Marshall"})

        expect(ic.contact_id).to eq(contact_3.id)
        incident_contact_params = ({ title: "Incident Commander" })

        headers = {"CONTENT_TYPE" => "application/json"}
        patch "/api/v1/incidents/#{incident.id}/contacts/#{contact_1.id}", headers: headers, params: JSON.generate(incident_contact_params)

        result = JSON.parse(response.body, symbolize_names: true)
        incident_contact_1 = IncidentContact.last

        expect(incident_contact_1.contact_id).to eq(contact_1.id)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(result).to be_a(Hash)
        expect(result[:data]).to be_a(Hash)
        expect(result[:data].count).to eq(3)
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:id]).to be_a(String)
        expect(result[:data][:id]).to eq(contact_1.id.to_s)
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
        role_1 = create(:role, title: "Incident Commander")
        incident = create(:incident)
        incident_2 = create(:incident)
        contact_1 = create(:contact, job_title: "Incident Commander")
        contact_2 = create(:contact, job_title: "Incident Commander")
        contact_1.roles << role_1
        contact_2.roles << role_1

        ic = IncidentContact.create({incident_id: incident.id, contact_id: contact_2.id, title: "Incident Commander"})

        incident_contact_params = ({ title: "" })

        headers = {"CONTENT_TYPE" => "application/json"}
        patch "/api/v1/incidents/#{incident.id}/contacts/#{contact_2.id}", headers: headers, params: JSON.generate(incident_contact_params)

        error = JSON.parse(response.body, symbolize_names: true)
        error_message = "Title must be assigned"

        expect(response).to have_http_status(400)
        expect(error).to have_key(:error)
        expect(error[:error]).to eq("#{error_message}")
      end
      it 'cannot add a contact to an incident if the incident does not exist' do
        role_1 = create(:role, title: "Incident Commander")
        incident = create(:incident)
        incident_2 = create(:incident)
        contact_1 = create(:contact, job_title: "Incident Commander")
        contact_2 = create(:contact, job_title: "Incident Commander")
        contact_1.roles << role_1
        contact_2.roles << role_1

        ic = IncidentContact.create({incident_id: incident.id, contact_id: contact_2.id, title: "Incident Commander"})

        incident_contact_params = ({ title: "Incident Commander" })

        headers = {"CONTENT_TYPE" => "application/json"}
        patch "/api/v1/incidents/8746315193845/contacts/#{contact_2.id}", headers: headers, params: JSON.generate(incident_contact_params)

        error = JSON.parse(response.body, symbolize_names: true)
        error_message = "Incident does not exist"

        expect(response).to have_http_status(404)
        expect(error).to have_key(:error)
        expect(error[:error]).to eq("#{error_message}")
      end
      it 'cannot add a contact to an incident if the contact does not exist' do
        role_1 = create(:role, title: "Incident Commander")
        incident = create(:incident)
        incident_2 = create(:incident)
        contact_1 = create(:contact, job_title: "Incident Commander")
        contact_2 = create(:contact, job_title: "Incident Commander")
        contact_1.roles << role_1
        contact_2.roles << role_1

        ic = IncidentContact.create({incident_id: incident.id, contact_id: contact_2.id, title: "Incident Commander"})

        incident_contact_params = ({ title: "Incident Commander" })

        headers = {"CONTENT_TYPE" => "application/json"}
        patch "/api/v1/incidents/#{incident.id}/contacts/87346528345", headers: headers, params: JSON.generate(incident_contact_params)

        error = JSON.parse(response.body, symbolize_names: true)
        error_message = "Contact does not exist"

        expect(response).to have_http_status(404)
        expect(error).to have_key(:error)
        expect(error[:error]).to eq("#{error_message}")
      end
      it 'cannot add a contact to an incident if the contact is already assigned to an active incident' do
        incident = create(:incident, active: true)
        incident_2 = create(:incident, active: true)
        contact = create(:contact, job_title: "Safety Officer")
        IncidentContact.create({contact_id: contact.id, incident_id: incident_2.id, title: contact.job_title})
        incident_contact_params = ({ title: "Safety Officer" })

        headers = {"CONTENT_TYPE" => "application/json"}
        patch "/api/v1/incidents/#{incident.id}/contacts/#{contact.id}", headers: headers, params: JSON.generate(incident_contact_params)

        error = JSON.parse(response.body, symbolize_names: true)
        error_message = "Contact is assigned to another incident"

        expect(response).to have_http_status(400)
        expect(error).to have_key(:error)
        expect(error[:error]).to eq("#{error_message}")
      end
    end
  end
end
