FactoryGirl.define do
  factory :user do
    transient do
      has_document false
    end

    email Faker::Internet.email
    password Faker::Internet.password

    after(:create) do |user, evaluator|
      if evaluator.has_document
        document = build(:document)
        document.assign_to(user)
        document.save
      end
    end
  end
end
