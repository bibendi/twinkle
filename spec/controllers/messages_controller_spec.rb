require "spec_helper"

describe MessagesController do
  let(:user) { create :user }
  let(:channel) { create :channel, user: user }
  let(:telegram) { create :telegram_transport, user: user, channel: channel }

  it "returns 403 when token is invalid" do
    post :create, token: "bad"
    expect(response.status).to eq 403
  end

  it "returns 400 when channel is blank" do
    post :create, token: user.token, message: "msg"
    expect(response.status).to eq 400
  end

  it "returns 400 when message is blank" do
    post :create, token: user.token, channel: channel.name
    expect(response.status).to eq 400
  end

  it "returns 200 when all params is valid" do
    post :create, token: user.token, channel: channel.name, message: "msg"
    expect(SendMessageJob).to have_queued(user.id, channel.name, "msg")
    expect(response.status).to eq 200
  end
end
