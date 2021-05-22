require 'rails_helper'

RSpec.describe ContactRole, type: :model do
  describe "relationships" do
    it { should belong_to :contact}
    it { should belong_to :role}
  end
end
