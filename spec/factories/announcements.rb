FactoryBot.define do
  factory :announcement do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
