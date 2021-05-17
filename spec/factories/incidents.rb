FactoryBot.define do
  factory :incident do
    name { "Camp Fire" }
    active { false }
    type { "Fire" }
    description { "MyString" }
    location { "MyString" }
    start_date { "2021-05-01 12:22:48" }
    closed_date { "2021-05-2 12:22:48" }
  end
end
