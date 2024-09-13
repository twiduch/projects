FactoryBot.define do
  factory :comment do
    user
    project
    content { Faker::Lorem.sentence }
  end
end
