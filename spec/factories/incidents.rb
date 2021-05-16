FactoryBot.define do
  factory :incident do
    name { "MyString" }
    active { false }
    type { "" }
    description { "MyString" }
    location { "MyString" }
    start_date { "2021-05-16 12:22:48" }
    closed_date { "2021-05-16 12:22:48" }
  end
end
