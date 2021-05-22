require 'rails_helper'

RSpec.describe 'Create an Incident Contact Endpoint' do
  describe 'post request to add a contact to an incident with a specific title/role' do
    describe 'happy path' do
      it 'can add a contact to an incident with a specific role' do
        incident = create(:incident, active: true)
      end
    end
  end
end
