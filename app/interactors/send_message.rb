class SendMessage < ApplicationInteractor
  params :channel, :message, :vars

  validates :channel, :message, presence: true

  def perform
    return if !channel.active? || !channel.client.active?

    @formatted_message = format_message

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
    transport.deliver(@formatted_message)
    context.sent_count += 1
  rescue => error
    @transport_errors << error
  end

  def format_message
    return message if vars.blank?
    message % flat_hash(vars).symbolize_keys
  end

  def flat_hash(hash, path = "")
    hash.each_with_object({}) do |(key, value), ret|
      key_path = path + key

      if value.is_a?(Hash)
        ret.merge! flat_hash(value, key_path + ".")
      else
        ret[key_path] = value
      end
    end
  end
end
