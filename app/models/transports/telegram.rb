module Transports
  class Telegram < Transport
    jsonb_accessor :data,
                   chat_id: :integer

    validates :chat_id, presence: true

    def forwarder
      Forwarders::SendTelegram
    end
  end
end
