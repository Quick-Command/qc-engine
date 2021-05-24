require 'rails_helper'

RSpec.describe IncidentContactInfo do
  it "exists" do
    attributes = {
      name: "Jerry Lewis",
      title: "Incident Commander",
      email: "jlewis@fakemail.com",
      phone_number: "123-456-6982",
      incident_location: "Denver, CO",
      contact_location: "Denver, CO"
    }

    contact = IncidentContactInfo.new(attributes)

    expect(contact).to be_an IncidentContactInfo
    expect(contact.name).to eq(attributes[:name])
    expect(contact.title).to eq(attributes[:title])
    expect(contact.email).to eq(attributes[:email])
    expect(contact.phone_number).to eq(attributes[:phone_number])
    expect(contact.distance_miles.to_i).to be >(0)
    expect(contact.distance_minutes.to_i).to be >(0) 
  end
end
