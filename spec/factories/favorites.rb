FactoryBot.define do
  factory :favorite do
    association :user
    association :course
  end
end
