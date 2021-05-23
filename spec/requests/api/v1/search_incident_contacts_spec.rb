require 'rails_helper'

RSpec.describe "Search for a contact by role" do
  describe "happy path" do
    it "should return a contact that matches the role" do
      contact_1 = create(:contact, job_title: "Incident Commander")
      contact_2 = create(:contact, job_title: "Incident Commander")
      contact_3 = create(:contact, job_title: "Incident Commander")
      contact_4 = create(:contact, job_title: "Safety Officer")
      contact_5 = create(:contact, job_title: "Safety Officer")

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
  end
end
