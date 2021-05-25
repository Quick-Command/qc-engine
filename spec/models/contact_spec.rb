require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
  end

  describe "relationships" do
    it { should have_many(:incident_contacts) }
    it { should have_many(:incidents).through(:incident_contacts) }
    it { should have_many(:contact_roles) }
    it { should have_many(:roles).through(:contact_roles) }
  end

  describe "instance variables" do
    describe "#assigned_to_active_incident?" do
      it "returns true if a contact is assigned to an active incident" do
        role_1 = create(:role, title: "Incident Commander")
        role_2 = create(:role, title: "Safety Officer")
        incident = create(:incident, active: true)
        incident_2 = create(:incident, active: false)
        contact_1 = create(:contact, job_title: "Incident Commander")
        contact_2 = create(:contact, job_title: "Incident Commander")
        contact_3 = create(:contact, job_title: "Incident Commander")
        ic = IncidentContact.create({incident_id: incident.id, contact_id: contact_3.id, title: "Incident Commander"})
        ic2 = IncidentContact.create({incident_id: incident_2.id, contact_id: contact_2.id, title: "Incident Commander"})
        ic3 = IncidentContact.create({incident_id: incident_2.id, contact_id: contact_3.id, title: "Incident Commander"})
        contact_4 = create(:contact, job_title: "Safety Officer")
        contact_5 = create(:contact, job_title: "Safety Officer")
        contact_1.roles << role_1
        contact_2.roles << role_1
        contact_3.roles << role_1
        contact_4.roles << role_2
        contact_5.roles << role_2

        expect(contact_3.assigned_to_active_incident?).to eq(true)
        expect(contact_1.assigned_to_active_incident?).to eq(false)
        expect(contact_2.assigned_to_active_incident?).to eq(false)
        expect(contact_4.assigned_to_active_incident?).to eq(false)
        expect(contact_5.assigned_to_active_incident?).to eq(false)
      end
    end
  end
  describe "class methods" do
    it "::search" do
      contact = create(:contact, name: "Karen Shmaren")
      contact2 = create(:contact, name: "Joe Shmoe")
      contact3 = create(:contact, name: "Jimmy Shmimmy")

      search_term = 'Shma'

      expect(Contact.search(search_term).length).to eq(1)
      expect(Contact.search(search_term).first.name).to eq(contact.name)
    end
  end
end
