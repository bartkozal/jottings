FactoryGirl.define do
  factory :user do
    transient do
      has_document false
      has_bookmark false
    end

    name Faker::Name.name
    sequence(:email) { |n| Faker::Internet.email(n) }
    password Faker::Internet.password

    after(:create) do |user, evaluator|
      if evaluator.has_document
        document = build(:document)
        document.assign_to(user)
        document.save
      end

      if evaluator.has_bookmark
        document = build(:document)
        document.assign_to(user)
        document.save

        create(:bookmark, user: user, document: document)
      end
    end
  end
end
