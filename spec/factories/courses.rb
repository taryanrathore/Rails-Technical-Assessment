FactoryBot.define do
  factory :course do
    title { Faker::Educator.course_name }
    status { :active }
    term
    sequence(:code) { |n| "IT-#{100 + n}-OLA1" }
  end
end
