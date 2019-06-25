FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "blabla" }
  end
end