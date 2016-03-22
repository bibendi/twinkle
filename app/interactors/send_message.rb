class SendMessage
  include Interactor
  include ActiveModel::Validations

  delegate :channel_or_name, to: :context
  delegate :message, to: :context

  validates :channel_or_name, presence: true
  validates :message, presence: true
  validates :channel, presence: true

  def call
    context.fail!(errors: errors) unless valid?

    forwarder_errors = []
    channel.transports.each do |transport|
      forwarder_options = transport.options.merge(message: message)
      forwarder_context = forwarder_for(transport).call(forwarder_options)
      forwarder_errors << forwarder_context.errors unless forwarder_context.success?
    end

    context.fail!(errors: forwarder_errors) if forwarder_errors.any?
  end

  private

  def channel
    return @channel if defined?(@channel)

    @channel = if channel_or_name.respond_to?(:transports)
                 channel_or_name
               else
                 Channel.find(name: channel_or_name).first
               end
  end

  def forwarder_for(transport)
    "forwarders/send_#{transport.name}".camelize.constantize
  end
end
