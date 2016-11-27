require "spec_helper"

describe AvailableTransportsFinder do
  it "finds available channel's transports" do
    client = create :client
    channel = create :channel, client: client
    telegram1 = create :telegram_transport, client: client, channel: channel
    telegram2 = create :telegram_transport, client: client

    transports = described_class.new(channel)
    expect(transports.size).to eq 1
    expect(transports.first).to eq telegram2
  end
end
