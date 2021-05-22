require 'rails_helper'

RSpec.describe Role, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
    it { should validate_uniqueness_of :title }
    it { should have_many(:contact_roles) }
    it { should have_many(:contacts).through(:contact_roles) }
  end
end
