FactoryBot.define do
  factory :address do
    post_code { '111-1111' }
    address { '東京都' }
    tel { '1234567890' }
    emergency_contact_tel { '1234567890' }
    emergency_contact_name { Faker::Name.name }
  end
end
