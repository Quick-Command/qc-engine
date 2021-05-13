FactoryBot.define do
  factory :contact do
    name { Faker::Name.unique.name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.cell_phone }
  end
end
