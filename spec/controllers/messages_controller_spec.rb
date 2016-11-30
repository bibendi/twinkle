require "spec_helper"

describe MessagesController do
  let(:client) { create :client }
  let(:channel) { create :channel, client: client }
  let(:telegram) { create :telegram_transport, client: client, channel: channel }

  it "returns 401 when token is invalid" do
    post :create, token: "bad"
    expect(response.status).to eq 403
  end

  it "returns 400 when channel is blank" do
    post :create, token: client.token, message: "msg"
    expect(response.status).to eq 400
  end

  it "returns 400 when message is blank" do
    post :create, token: client.token, channel: channel.name
    expect(response.status).to eq 400
  end

  context "when all params is valid" do
    it "returns 200 when has no json vars" do
      post :create, token: client.token, channel: channel.name, message: "msg"
      expect(SendMessageJob).to have_queued(client.id, channel.name, "msg", nil)
      expect(response.status).to eq 200
    end

    it "returns 200 when has a json vars" do
      post :create, token: client.token, channel: channel.name, message: "msg", json_vars: "data", data: '{"key": 1}'
      expect(SendMessageJob).to have_queued(client.id, channel.name, "msg", '{"key": 1}')
      expect(response.status).to eq 200
    end
  end
end
