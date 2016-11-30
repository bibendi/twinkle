FactoryGirl.define do
  factory :client do
    sequence(:name) { |n| "client#{n}" }
  end
end
