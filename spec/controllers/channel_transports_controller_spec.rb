require "spec_helper"

describe ChannelTransportsController do
  let(:user) { create :user }
  let(:client) { create :client }
  let(:channel) { create :channel, client: client }

  before { authenticate(user) }

  describe "#new" do
    it "builds a channel_transport" do
      response = get :new, client_id: client.id, channel_id: channel.id
      expect(assigns(:channel_transport)).to_not be_persisted
      expect(response.status).to eq 200
    end
  end

  describe "#create" do
    context "when successfull" do
      it "creates a channel_transport" do
        telegram = create :telegram_transport, client: client
        response = post :create, client_id: client.id, channel_id: channel.id,
                        channel_transport: {transport_id: telegram.id}
        expect(assigns(:channel_transport)).to be_persisted
        expect(response).to redirect_to(client_channel_path(client, channel))
      end
    end

    context "when failed" do
      it "doesn't redirect" do
        telegram = create :telegram_transport
        response = post :create, client_id: client.id, channel_id: channel.id,
                        channel_transport: {transport_id: telegram.id}
        expect(assigns(:channel_transport)).to_not be_persisted
        expect(response.status).to eq 200
      end
    end
  end

  describe "#destroy" do
    it "destroy a channel_transport" do
      telegram = create :telegram_transport, client: client, channel: channel
      response = delete :destroy, client_id: client.id, channel_id: channel.id, id: telegram.id
      expect(channel.reload.transports).to be_empty
      expect(response).to redirect_to(client_channel_path(client, channel))
    end
  end
end
