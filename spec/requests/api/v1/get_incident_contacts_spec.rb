require 'rails_helper'

RSpec.describe 'Get an Incident Contacts Endpoint' do
  describe 'happy path' do
    it 'can return all contacts assigned to the incident' do
      role_1 = create(:role, title: "Incident Commander")
      role_2 = create(:role, title: "Safety Officer")
      role_3 = create(:role, title: "Fire Marshall")
      incident = create(:incident)
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
      ic = IncidentContact.create({incident_id: incident.id, contact_id: contact_4.id, title: "Safety Officer"})
      ic = IncidentContact.create({incident_id: incident.id, contact_id: contact_5.id, title: "Fire Marshall"})

      get "/api/v1/incidents/#{incident.id}/contacts"
      expect(response).to be_successful
      contacts = JSON.parse(response.body, symbolize_names:true)

      expect(contacts).to be_a(Hash)
      expect(contacts[:data]).to be_an(Array)
      expect(contacts[:data].first).to be_a(Hash)
      expect(contacts[:data].first[:type]).to eq('incident_contact')
      expect(contacts[:data].count).to eq(3)
      expect(contacts[:data].first[:id]).to eq(contact_3.id.to_s)
      expect(contacts[:data].last[:id]).to eq(contact_5.id.to_s)
      expect(result).to be_a(Hash)
      expect(contacts[:data]).to be_a(Hash)
      expect(contacts[:data].count).to eq(3)
      expect(contacts[:data]).to have_key(:id)
      expect(contacts[:data][:id]).to be_a(String)
      expect(contacts[:data][:id]).to eq(contact.id.to_s)
      expect(contacts[:data]).to have_key(:type)
      expect(contacts[:data][:type]).to eq("incident_contact")
      expect(contacts[:data]).to have_key(:attributes)
      expect(contacts[:data][:attributes]).to be_a(Hash)
      expect(contacts[:data][:attributes].count).to eq(8)
      expect(contacts[:data][:attributes]).to have_key(:title)
      expect(contacts[:data][:attributes][:title]).to be_a(String)
      expect(contacts[:data][:attributes]).to have_key(:distance_miles)
      expect(contacts[:data][:attributes][:distance_miles]).to be_a(String)
      expect(contacts[:data][:attributes]).to have_key(:distance_minutes)
      expect(contacts[:data][:attributes][:distance_minutes]).to be_a(String)
    end
  end
  describe 'sad path' do
    xit 'cannot display and incident contact that does not exist' do
      incident = create(:incident, active: true)
      contact = create(:contact, job_title: "Safety Officer")
      get "/api/v1/incidents/#{incident.id}/contacts/#{contact.id}"
      result = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(404)
      expect(result).to be_a(Hash)
      expect(result[:error]).to eq("Contact is not assigned to incident")
    end
  end
end