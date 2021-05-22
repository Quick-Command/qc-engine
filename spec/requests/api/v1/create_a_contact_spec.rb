require 'rails_helper'

RSpec.describe 'Create A Contact Endpoint' do
  describe 'post request to create a contact' do
    describe 'happy path' do
      it 'can create a contact with multiple roles' do
        create_list(:contact, 10)
        contact_1 = Contact.all.first
        contact_2 = Contact.all[1]
        role_1 = create(:role, title: "Commander in Cheif")
        role_2 = create(:role, title: "Safety Officer")

        create(:contact_role, contact_id: contact_1.id, role_id: role_1.id)
        create(:contact_role, contact_id: contact_1.id, role_id: role_2.id)
        contact_id = Contact.all.first

        post "/api/v1/contacts/#{contact_id.id}"

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(result).to be_a(Hash)
        expect(result[:data]).to be_a(Hash)
        expect(result[:data].count).to eq(3)
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:id]).to be_a(String)
        expect(result[:data][:id]).to eq(contact_id.id.to_s)
        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to eq("contact")
        expect(result[:data]).to have_key(:attributes)
        expect(result[:data][:attributes]).to be_a(Hash)
        expect(result[:data][:attributes].count).to eq(6)
        expect(result[:data][:attributes]).to have_key(:name)
        expect(result[:data][:attributes][:name]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:email)
        expect(result[:data][:attributes][:email]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:phone_number)
        expect(result[:data][:attributes][:phone_number]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:job_title)
        expect(result[:data][:attributes][:job_title]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:city)
        expect(result[:data][:attributes][:job_title]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:state)
        expect(result[:data][:attributes][:job_title]).to be_a(String)
      end
    end
  end
end
