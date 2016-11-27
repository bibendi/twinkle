require "spec_helper"

describe EnqueueMessage do
  let(:client) { create :client }
  let(:channel) { create :channel, client: client }

  context "when no json vars" do
    subject(:context) { described_class.call(client: client, channel_name: channel.name, message: "msg") }

    it "enqueue a message" do
      expect(context).to be_a_success
      expect(SendMessageJob).to have_queued(client.id, channel.name, "msg", nil)
    end
  end

  context "when json vars provided" do
    subject(:context) do
      described_class.call(client: client, channel_name: channel.name, message: "msg", json_vars: '{"key": 1}')
    end

    it "enqueue a message" do
      expect(context).to be_a_success
      expect(SendMessageJob).to have_queued(client.id, channel.name, "msg", '{"key": 1}')
    end
  end
end
