require 'rails_helper'

RSpec.describe 'Contact Details API' do
  describe 'Get contact details' do
    describe 'happy path' do
      it 'can return a specific contact with their details by a contact id' do
        create_list(:contact, 10)
        contact_id = Contact.all.first

        get "/api/v1/contacts/#{contact_id.id}"

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
        expect(result[:data][:attributes][:roles]).to be_a(Hash)
        expect(result[:data][:attributes][:roles][:data]).to be_an(Array)
        expect(result[:data][:attributes][:roles][:data].first).to be_a(Hash)
        expect(result[:data][:attributes][:roles][:data].first.keys).to be_a(Hash)
        expect(result[:data][:attributes][:roles][:data].first.keys).to eq([:id, :type, :attributes])
        expect(result[:data][:attributes][:roles][:data].first[:type]).to eq("role")
        expect(result[:data][:attributes][:roles][:data].first[:attributes]).to be_a(Hash)
        expect(result[:data][:attributes][:roles][:data].first[:attributes].keys).to eq([:title])
      end
    end
  end
end
