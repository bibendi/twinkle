FactoryGirl.define do
  factory :channel do
    sequence(:name) { |n| "channel#{n}" }
    association :user
  end
end
