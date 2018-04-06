FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "username#{n}@example.com" }
    sequence(:username) { |n| "username#{n}" }

    trait :admin do
      role_id { ::Role.find_by_name("admin").id }
    end
  end
end
