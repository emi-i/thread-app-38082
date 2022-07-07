FactoryBot.define do
  factory :diary do
    title { Faker::Name.name }
    content { Faker::Lorem.sentence }
    date { Faker::Date.birthday }
    release_id { '1' }
    association :user
  end
end
