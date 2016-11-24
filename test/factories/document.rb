FactoryGirl.define do
  factory :document do
    transient do
      user nil
    end

    name Faker::Lorem.words.join.titleize

    after(:build) do |document, evaluator|
      if user = evaluator.user.presence
        document.stack = user.root_stack
      end
    end

    after(:create) do |document, evaluator|
      PaperTrail.whodunnit = "1"
    end
  end
end
