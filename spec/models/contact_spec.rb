require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :job_title }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
  end

  describe "relationships" do
    it { should have_many(:incident_contacts) }
    it { should have_many(:incidents).through(:incident_contacts) }
    it { should have_many(:contact_roles) }
    it { should have_many(:roles).through(:contact_roles) }
  end
end
