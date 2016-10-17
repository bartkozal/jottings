FactoryGirl.define do
  factory :document do
    body Faker::Lorem.paragraphs.join("\r\n")
  end
end
