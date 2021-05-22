require 'rails_helper'

RSpec.describe IncidentContact, type: :model do
  describe "relationships" do
    it { should belong_to :incident }
    it { should belong_to :contact }
  end
end
