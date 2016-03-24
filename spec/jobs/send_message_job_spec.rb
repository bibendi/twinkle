require "spec_helper"

describe SendMessageJob do
  let(:channel) { create :channel }
  let(:user) { channel.user }

  it "calls interactor" do
    expect(SendMessage).to receive(:call!).with(channel: channel, message: "msg")
    described_class.perform(user.id, channel.name, "msg")
  end
end
