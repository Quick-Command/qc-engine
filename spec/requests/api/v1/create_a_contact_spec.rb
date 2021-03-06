require 'rails_helper'

RSpec.describe 'Create A Contact Endpoint' do
  describe 'post request to create a contact' do
    describe 'happy path' do
      it 'can create a contact with multiple roles' do
        role_1 = create(:role, title: "Commander in Cheif")
        role_2 = create(:role, title: "Safety Officer")

        contact_params = ({
          name: "Wells Fergi",
          email: "wfergi@email.com",
          phone_number: "123-456-7890",
          job_title: "Fire Commander",
          city: "Denver",
          state: "CO",
          roles: ["#{role_1.title}", "#{role_2.title}"]
          })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/contacts", headers: headers, params: JSON.generate(contact_params)

        result = JSON.parse(response.body, symbolize_names: true)
        contact_1 = Contact.last

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(result).to be_a(Hash)
        expect(result[:data]).to be_a(Hash)
        expect(result[:data].count).to eq(3)
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:id]).to be_a(String)
        expect(result[:data][:id]).to eq(contact_1.id.to_s)
        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to eq("contact")
        expect(result[:data]).to have_key(:attributes)
        expect(result[:data][:attributes]).to be_a(Hash)
        expect(result[:data][:attributes].count).to eq(7)
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
        expect(result[:data][:attributes][:roles][:data].first.keys).to eq([:id, :type, :attributes])
        expect(result[:data][:attributes][:roles][:data].first[:type]).to eq("role")
        expect(result[:data][:attributes][:roles][:data].first[:attributes]).to be_a(Hash)
        expect(result[:data][:attributes][:roles][:data].first[:attributes].keys).to eq([:title])
      end
    end
    describe 'sad path' do
      it 'cannot create a contact without at least one role' do
        role_1 = create(:role, title: "Commander in Cheif")
        role_2 = create(:role, title: "Safety Officer")

        contact_params = ({
          name: "Wells Fergi",
          email: "wfergi@email.com",
          phone_number: "123-456-7890",
          job_title: "Fire Commander",
          city: "Denver",
          state: "CO",
          roles: []
          })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/contacts", headers: headers, params: JSON.generate(contact_params)

        result = JSON.parse(response.body, symbolize_names: true)
        contact_1 = Contact.last

        error = JSON.parse(response.body, symbolize_names: true)
        error_message = "At least one role must be selected"

        expect(response).to have_http_status(400)
        expect(error).to have_key(:error)
        expect(error[:error]).to eq("#{error_message}")
      end
      it 'cannot create a contact without a name, email, and phone' do
        role_1 = create(:role, title: "Commander in Cheif")
        role_2 = create(:role, title: "Safety Officer")

        contact_params = ({
          name: "",
          email: "wfergi@email.com",
          phone_number: "123-456-7890",
          job_title: "Fire Commander",
          city: "Denver",
          state: "CO",
          roles: ["#{role_1.title}", "#{role_2.title}"]
          })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/contacts", headers: headers, params: JSON.generate(contact_params)

        result = JSON.parse(response.body, symbolize_names: true)
        contact_1 = Contact.last

        error = JSON.parse(response.body, symbolize_names: true)
        error_message = "Name, email, phone, city, or state cannot be blank"

        expect(response).to have_http_status(400)
        expect(error).to have_key(:error)
        expect(error[:error]).to eq("#{error_message}")
      end
    end
  end
end
