require 'rails_helper'

RSpec.describe Role, type: :model do
  describe "validations" do
    it { should validate_presence_of :title }
  end
end
