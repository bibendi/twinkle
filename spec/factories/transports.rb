FactoryGirl.define do
  factory :transport do
    association :user

    transient do
      channel nil
    end

    after(:create) do |transport, params|
      params.channel.transports << transport if params.channel
    end

    factory :telegram_transport, class: Transports::Telegram do
      sequence(:chat_id)
    end
  end
end
