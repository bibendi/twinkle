class SendMessageJob
  @queue = :messages

  def self.perform(user_id, channel_name, message)
    user = User.find(Integer(user_id))
    channel = user.channels.find_by!(name: channel_name)

    SendMessage.call!(channel: channel, message: message)
  end
end
