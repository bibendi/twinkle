class SendMessageJob
  @queue = :messages

  def self.perform(client_id, channel_name, message, json_vars)
    client = Client.find(Integer(client_id))
    channel = client.channels.find_by!(name: channel_name)
    vars = json_vars.present? ? JSON.parse(json_vars) : {}

    SendMessage.call!(channel: channel, message: message, vars: vars)
  end
end
