FactoryBot.define do
  factory :assignment do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    course
  end
end
