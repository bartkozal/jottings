FactoryGirl.define do
  factory :document do
    body Faker::Lorem.paragraphs.join("\n\n")
  end
end
