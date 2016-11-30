require "telegram/bot"

module Transports
  class Telegram < Transport
    jsonb_accessor :data,
                   chat_name: :string,
                   chat_id: :integer

    validates :chat_name, presence: true
    validates :chat_id, presence: true

    def name
      chat_name
    end

    # :nocov:
    def deliver(message)
      token = Rails.application.config.twinkle.telegram.bot_token
      ::Telegram::Bot::Client.run(token) do |bot|
        bot.api.send_message(
          text: message,
          chat_id: Integer(chat_id)
        )
      end
    end
    # :nocov:
  end
end
