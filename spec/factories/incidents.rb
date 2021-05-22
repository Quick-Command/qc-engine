FactoryBot.define do
  factory :incident do
    name { "Camp Fire" }
    active { [true, false].sample }
    incident_type { ["Fire", "Accident", "Earthquake", "Hazmat Spill", "Power Outage"].sample }
    description { "This is a description of the incident" }
    location { "Denver, CO" }
    start_date { "2021-05-01 12:22:48" }
    close_date { "2021-05-2 12:22:48" }
    city { "Denver" }
    state { "CO" }
  end
end
