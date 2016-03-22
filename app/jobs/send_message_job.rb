class SendMessageJob
  @queue = :messages

  def self.perform(channel_name, message)
    SendMessage.call!(channel_or_name: channel_name, message: message)
  end
end
