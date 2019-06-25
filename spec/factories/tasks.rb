FactoryBot.define do
  factory :task do
    transient do
      project_id { nil }
    end
    name { Faker::Lorem.characters(20) }
    done { false }
    before(:create) do |task, evaluator|
      task.project_id = evaluator.project_id
    end
  end
end