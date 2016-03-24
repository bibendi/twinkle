require "spec_helper"

describe ChannelTransport do
  it "doesn't link channel with transport of other user" do
    channel = create(:channel)
    transport = create(:telegram_transport)

    channel_transport = ChannelTransport.new(channel: channel, transport: transport)
    expect(channel_transport).to_not be_valid
    expect(channel_transport.errors.messages.keys).to include :transport
  end
end
