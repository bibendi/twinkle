class SendMessage < ApplicationInteractor
  params :channel, :message

  validates :channel, :message, presence: true

  def perform
    return if !channel.active? || !channel.user.active?

    context.sent_count = 0
    @transport_errors = []

    channel.transports.each do |transport|
      forward(transport)
    end

    return if @transport_errors.empty?
    context.fail!(message: @transport_errors.map(&:message).join("; "))
  end

  private

  def forward(transport)
    transport.deliver(message)
    context.sent_count += 1
  rescue => error
    @transport_errors << error
  end
end
