FactoryGirl.define do
  factory :channel do
    sequence(:name) { |n| "channel#{n}" }
    association :client
  end
end
