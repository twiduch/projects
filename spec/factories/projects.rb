FactoryBot.define do
  factory :project do
    name { Faker::App.name }
    status { "planned" }
  end
end
