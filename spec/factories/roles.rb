FactoryBot.define do
  factory :role do
    title { ["Incident Commander", "Safety Officer", "Liaison Officer", "Operations Chief", "Logistics Chief"].sample }
  end
end
