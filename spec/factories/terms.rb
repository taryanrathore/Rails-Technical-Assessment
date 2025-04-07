FactoryBot.define do
  factory :term do
    name { Faker::Educator.university }
  end
end
