class SendMessage < ApplicationInteractor
  FORWARDERS = {
    "Transports::Telegram" => Forwarders::SendTelegram
  }.freeze

  params :user_id, :channel_name, :message

  validates :user_id, :channel_name, :message, presence: true

  def perform
    return unless user.active? || channel.active?
    send
  end

  private

  def send
    errors = []
    channel.transports.each do |transport|
      forwarder_context = FORWARDERS[transport.type].call(message: message, transport: transport)
      errors << forwarder_context.message if forwarder_context.failure?
    end

    context.fail!(message: errors.join("; ")) if errors.any?
  end

  def user
    @user ||= User.find(user_id)
  end

  def channel
    @channel ||= user.channels.find_by!(name: channel_name)
  end
end
