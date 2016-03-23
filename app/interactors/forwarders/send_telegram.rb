require "telegram/bot"

module Forwarders
  class SendTelegram < ApplicationInteractor
    delegate :message, to: :context
    delegate :transport, to: :context

    validates :message, presence: true
    validates :transport, presence: true

    def call
      validate!

      ::Telegram::Bot::Client.run(ENV.fetch("TELEGRAM_BOT_TOKEN")) do |bot|
        bot.api.send_message(
          text: message,
          chat_id: Integer(transport.chat_id)
        )
      end
    end
  end
end
