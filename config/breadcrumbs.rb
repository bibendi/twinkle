crumb :profile do |user|
  link user.username, profile_url
end

crumb :clients do
  link 'Clients', clients_url
end

crumb :client do |client|
  link client.name, client_path(client)
  parent :clients
end

crumb :channels do |client|
  link "Channels", client_channels_path(client)
  parent :client, client
end

crumb :channel do |client, channel|
  link channel.name, client_channel_path(client, channel)
  parent :channels, client
end

crumb :telegrams do |client|
  link "Telegrams", client_transports_telegrams_path(client)
  parent :client, client
end

crumb :telegram do |client, telegram|
  link "Telegram", client_transports_telegram_path(client, telegram)
  parent :telegrams, client
end
