FactoryBot.define do
  factory :comment do
    transient do
      task_id { nil }
    end
    content { Faker::Lorem.characters(20) }
    before(:create) do |comment, evaluator|
      comment.task_id = evaluator.task_id
    end
  end
end