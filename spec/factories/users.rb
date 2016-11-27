FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "username#{n}@example.com" }
    sequence(:username) { |n| "username#{n}" }
  end
end
