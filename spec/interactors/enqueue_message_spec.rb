require "spec_helper"

describe EnqueueMessage do
  let(:user) { create :user }
  let(:channel) { create :channel, user: user }

  subject(:context) { described_class.call(user: user, channel_name: channel.name, message: "msg") }

  it "enqueue a message" do
    expect(context).to be_a_success
    expect(SendMessageJob).to have_queued(user.id, channel.name, "msg")
  end
end
