require 'rails_helper'

RSpec.describe ContactFacade do
  describe 'happy path' do
    it 'can search for the specific contact by a given name' do
      Contact.destroy_all
      create_list(:contact, 20)
      contact = create(:contact)

      contact1 = Contact.search(contact.name)

      expect(contact1.count).to eq(1)
      expect(contact1.first.name).to eq(contact.name)
    end
  end
end
