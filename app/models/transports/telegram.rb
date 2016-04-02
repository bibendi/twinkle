require "telegram/bot"

module Transports
  class Telegram < Transport
    jsonb_accessor :data,
                   chat_name: :string,
                   chat_id: :integer

    validates :chat_name, presence: true
    validates :chat_id, presence: true

    # :nocov:
    def deliver(message)
      ::Telegram::Bot::Client.run(ENV.fetch("TELEGRAM_BOT_TOKEN")) do |bot|
        bot.api.send_message(
          text: message,
          chat_id: Integer(chat_id)
        )
      end
    end
    # :nocov:
  end
end
