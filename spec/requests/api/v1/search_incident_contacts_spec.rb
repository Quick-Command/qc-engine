require 'rails_helper'

RSpec.describe "Search for a contact by role" do
  describe "happy path" do
    it "should return a contact that matches the role" do
      role_1 = create(:role, title: "Incident Commander")
      role_2 = create(:role, title: "Safety Officer")
      incident = create(:incident)
      contact_1 = create(:contact, job_title: "Incident Commander")
      contact_2 = create(:contact, job_title: "Incident Commander")
      contact_3 = create(:contact, job_title: "Incident Commander")
      ic = IncidentContact.create({incident_id: incident.id, contact_id: contact_3.id, title: "Incident Commander"})
      contact_4 = create(:contact, job_title: "Safety Officer")
      contact_5 = create(:contact, job_title: "Safety Officer")
      contact_1.roles << role_1
      contact_2.roles << role_1
      contact_3.roles << role_1
      contact_4.roles << role_2
      contact_5.roles << role_2

      get "/api/v1/contacts/contact_search?role=FFi"
      expect(response).to be_successful
      contacts = JSON.parse(response.body, symbolize_names:true)

      expect(contacts).to be_a(Hash)
      expect(contacts[:data]).to be_an(Array)
      expect(contacts[:data].first).to be_a(Hash)
      expect(contacts[:data].first[:type]).to eq('incident_contact')
      expect(contacts[:data].count).to eq(2)
      expect(contacts[:data].first[:id]).to eq(contact_4.id.to_s)
      expect(contacts[:data].last[:id]).to eq(contact_5.id.to_s)

      contact_ids = contacts[:data].map do |contact|
        contact[:id].to_i
      end
      expect(contact_ids.include?(contact_1.id)).to eq(false)
      expect(contact_ids.include?(contact_2.id)).to eq(false)
      expect(contact_ids.include?(contact_3.id)).to eq(false)
    end

    it "should return a contact that matches the role if they are not assigned to an active incident" do
      role_1 = create(:role, title: "Incident Commander")
      role_2 = create(:role, title: "Safety Officer")
      incident = create(:incident)
      contact_1 = create(:contact, job_title: "Incident Commander")
      contact_2 = create(:contact, job_title: "Incident Commander")
      contact_3 = create(:contact, job_title: "Incident Commander")
      ic = IncidentContact.create({incident_id: incident.id, contact_id: contact_3.id, title: "Incident Commander"})
      contact_4 = create(:contact, job_title: "Safety Officer")
      contact_5 = create(:contact, job_title: "Safety Officer")
      contact_1.roles << role_1
      contact_2.roles << role_1
      contact_3.roles << role_1
      contact_4.roles << role_2
      contact_5.roles << role_2

      get "/api/v1/contacts/contact_search?role=ComM"
      expect(response).to be_successful

      contacts = JSON.parse(response.body, symbolize_names:true)

      expect(contacts).to be_a(Hash)
      expect(contacts[:data]).to be_an(Array)
      expect(contacts[:data].first).to be_a(Hash)
      expect(contacts[:data].first[:type]).to eq('incident_contact')
      expect(contacts[:data].count).to eq(2)
      expect(contacts[:data].first[:id]).to eq(contact_1.id.to_s)
      expect(contacts[:data].last[:id]).to eq(contact_2.id.to_s)

      contact_ids = contacts[:data].map do |contact|
        contact[:id].to_i
      end
      expect(contact_ids.include?(contact_3.id)).to eq(false)
      expect(contact_ids.include?(contact_4.id)).to eq(false)
      expect(contact_ids.include?(contact_5.id)).to eq(false)
    end
  end
end
