class SendMessageJob
  @queue = :messages

  def self.perform(user_id, channel_name, message, json_vars)
    user = User.find(Integer(user_id))
    channel = user.channels.find_by!(name: channel_name)
    vars = json_vars.present? ? JSON.parse(json_vars) : {}

    SendMessage.call!(channel: channel, message: message, vars: vars)
  end
end
