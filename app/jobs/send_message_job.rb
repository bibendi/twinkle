class SendMessageJob
  @queue = :messages

  def self.perform(user_id, channel_name, message)
    SendMessage.call!(user_id: user_id, channel_or_name: channel_name, message: message)
  end
end
