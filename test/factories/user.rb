FactoryGirl.define do
  factory :user do
    transient do
      has_document false
      has_bookmark false
      has_stack false
    end

    name Faker::Name.name
    sequence(:email) { |n| Faker::Internet.email("#{name}-#{n}") }
    password Faker::Internet.password

    after(:create) do |user, evaluator|
      if evaluator.has_document
        create(:document, assign_to: user)
      end

      if evaluator.has_bookmark
        document = create(:document, assign_to: user)
        create(:bookmark, user: user, document: document)
      end

      if evaluator.has_stack
        create(:stack, assign_to: user)
      end
    end
  end
end
