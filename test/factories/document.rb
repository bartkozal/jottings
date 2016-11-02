FactoryGirl.define do
  factory :document do
    transient do
      assign_to nil
    end

    body Faker::Lorem.paragraphs.join("\n\n")

    after(:build) do |document, evaluator|
      if user = evaluator.assign_to.presence
        document.assign_to(user)
      end
    end

    after(:create) do |document, evaluator|
      PaperTrail.whodunnit = document.owner.id
    end
  end
end
