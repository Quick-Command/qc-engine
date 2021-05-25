require 'rails_helper'

RSpec.describe "Search for a contact by name" do
  describe "happy path" do
    it "should return a contact that matches the name given" do

      contact = create(:contact)

      get "/api/v1/contacts/find?name=#{contact.name}"
      expect(response).to be_successful
      expect(response.status).to eq(200)

      result = JSON.parse(response.body, symbolize_names:true)

      expect(result.count).to eq(1)
      expect(result[:data].count).to eq(3)
      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to be_a(String)
      attributes = result[:data][:attributes]
      expect(attributes).to be_a(Hash)
      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)
    end
  end

  # describe 'sad path' do
  #   it 'returns an error response when no match is found' do
  #     Contact.destroy_all
  #     contact = create_list(:contact, 20)
  #     contact2 = create(:contact, name: "chicken little")
  #
  #     get "/api/v1/contacts/find?name=!!!!"
  #
  #     result = JSON.parse(response.body, symbolize_names: true)
  #
  #     expect(response.status).to eq(400)
  #     expect(result).to have_key(:data)
  #   end
  #
  #   it 'returns an error response when no name param is given' do
  #     get "/api/v1/contacts/find"
  #
  #     result = JSON.parse(response.body, symbolize_names: true)
  #
  #     expect(response.status).to eq(400)
  #     expect(result).to have_key(:data)
  #   end
  # end
end
