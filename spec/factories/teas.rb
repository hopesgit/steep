FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { "MyString" }
    brew_time { Faker::Number.non_zero_digit }
    api_id { Faker::Alphanumeric.alpha(number: 10) }
  end
end
