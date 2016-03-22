require "telegram/bot"

module Forwarders
  class SendTelegram
    include Interactor
    include ActiveModel::Validations

    delegate :message, to: :context
    delegate :chat_id, to: :context

    validates :message, presence: true
    validates :chat_id, presence: true, numericality: {only_integer: true}

    def call
      context.fail!(errors: errors) unless valid?

      ::Telegram::Bot::Client.run(ENV.fetch("TELEGRAM_BOT_TOKEN")) do |bot|
        bot.api.send_message(
          text: message,
          chat_id: Integer(chat_id)
        )
      end
    end
  end
end
