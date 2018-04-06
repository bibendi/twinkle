require "spec_helper"

describe ChannelTransportsController do
  let(:user) { create :user, :admin }
  let(:client) { create :client }
  let(:channel) { create :channel, client: client }

  before do
    authenticate user
  end

  describe "#new" do
    it "builds a channel_transport" do
      response = get :new, client_id: client.id, channel_id: channel.id
      expect(response.status).to eq 200
      expect(assigns(:channel_transport)).to_not be_persisted
    end
  end

  describe "#create" do
    context "when successfull" do
      it "creates a channel_transport" do
        telegram = create :telegram_transport, client: client
        response = post :create, client_id: client.id, channel_id: channel.id,
                        channel_transport: {transport_id: telegram.id}
        expect(response).to redirect_to(client_channel_path(client, channel))
        expect(assigns(:channel_transport)).to be_persisted
      end
    end

    context "when failed" do
      it "doesn't redirect" do
        telegram = create :telegram_transport
        response = post :create, client_id: client.id, channel_id: channel.id,
                        channel_transport: {transport_id: telegram.id}
        expect(response.status).to eq 200
        expect(assigns(:channel_transport)).to_not be_persisted
      end
    end
  end

  describe "#destroy" do
    it "destroy a channel_transport" do
      telegram = create :telegram_transport, client: client, channel: channel
      response = delete :destroy, client_id: client.id, channel_id: channel.id, id: telegram.id
      expect(response).to redirect_to(client_channel_path(client, channel))
      expect(channel.reload.transports).to be_empty
    end
  end
end
