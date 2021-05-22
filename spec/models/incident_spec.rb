require 'rails_helper'

RSpec.describe Incident, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :incident_type }
  end

  describe "relationships" do
    it { should have_many(:incident_contacts) }
    it { should have_many(:contacts).through(:incident_contacts) }
  end

  describe "::class_methods" do
    describe "self.active(true/false)" do
      it "returns incidents with active status set to true" do
        create_list(:incident, 10, active: true)

        expect(Incident.active(true).count).to eq(10)
        expect(Incident.active(true).first.active).to eq(true)
      end
      it "returns incidents with active status set to false" do
        create_list(:incident, 10, active: false)

        expect(Incident.active(false).count).to eq(10)
        expect(Incident.active(false).first.active).to eq(false)
      end
    end
  end
end
