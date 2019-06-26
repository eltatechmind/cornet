# frozen_string_literal: true

FactoryBot.define do
  factory :project do
    transient do
      user_id { nil }
    end
    name { Faker::Lorem.characters(20) }
    before(:create) do |project, evaluator|
      project.user_id = evaluator.user_id
    end
  end
end
