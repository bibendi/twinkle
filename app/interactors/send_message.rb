class SendMessage < ApplicationInteractor
  TRANSPORT_FORWARDERS = {
    "Transports::Telegram" => Forwarders::SendTelegram
  }.freeze

  delegate :user_id, to: :context
  delegate :channel_name, to: :context
  delegate :message, to: :context

  validates :user_id, presence: true, numericality: {only_integer: true}
  validates :channel_name, presence: true
  validates :message, presence: true

  def call
    validate!

    return unless user.active?
    return unless channel.active?

    send
  end

  private

  def send
    errors = []
    channel.transports.each do |transport|
      forwarder_context = TRANSPORT_FORWARDERS[transport.type].call(message: message, transport: transport)
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
