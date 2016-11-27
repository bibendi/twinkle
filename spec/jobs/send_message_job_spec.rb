require "spec_helper"

describe SendMessageJob do
  let(:channel) { create :channel }
  let(:client) { channel.client }

  context "when no json vars" do
    it "calls interactor" do
      expect(SendMessage).to receive(:call!).with(channel: channel, message: "msg", vars: {})
      described_class.perform(client.id, channel.name, "msg", "")
    end
  end

  context "when with json vars" do
    it "calls interactor" do
      expect(SendMessage).to receive(:call!).with(channel: channel, message: "msg", vars: {"key" => 1})
      described_class.perform(client.id, channel.name, "msg", '{"key": 1}')
    end
  end
end
