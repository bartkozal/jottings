FactoryGirl.define do
  factory :stack do
    transient do
      assign_to nil
    end

    name Faker::Hacker.noun.titleize

    after(:build) do |stack, evaluator|
      if user = evaluator.assign_to.presence
        stack.assign_to(user)
      end
    end
  end
end
