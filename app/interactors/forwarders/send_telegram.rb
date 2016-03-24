require "telegram/bot"

module Forwarders
  class SendTelegram < ApplicationInteractor
    params :message, :transport

    validates :message, :transport, presence: true

    def perform
      ::Telegram::Bot::Client.run(ENV.fetch("TELEGRAM_BOT_TOKEN")) do |bot|
        bot.api.send_message(
          text: message,
          chat_id: Integer(transport.chat_id)
        )
      end
    end
  end
end
