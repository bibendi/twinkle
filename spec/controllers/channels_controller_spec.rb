require "spec_helper"

describe ChannelsController do
  let(:user) { create :user }
  let(:client) { create :client }
  let(:channel) { create :channel, client: client }

  before { authenticate(user) }

  describe "#index" do
    it "loads client's channels" do
      create_list :channel, 2, client: client
      response = get :index, client_id: client.id
      expect(assigns(:channels).size).to eq 2
      expect(response.status).to eq 200
    end
  end

  describe "#show" do
    it "find a channel" do
      response = get :show, client_id: client.id, id: channel.id
      expect(assigns(:channel)).to eq channel
      expect(response.status).to eq 200
    end
  end

  describe "#new" do
    it "build a channel" do
      response = get :new, client_id: client.id
      expect(assigns(:channel)).to_not be_persisted
      expect(response.status).to eq 200
    end
  end

  describe "#edit" do
    it "find a channel" do
      response = get :edit, client_id: client.id, id: channel.id
      expect(assigns(:channel)).to eq channel
      expect(response.status).to eq 200
    end
  end

  describe "#update" do
    context "when successfull" do
      it "updates a channel" do
        response = put :update, client_id: client.id, id: channel.id, channel: {name: "deploy"}
        expect(channel.reload.name).to eq "deploy"
        expect(response).to redirect_to(client_channels_path(client))
      end
    end

    context "when failed" do
      it "doesn't redirect" do
        response = put :update, client_id: client.id, id: channel.id, channel: {name: ""}
        expect(channel.reload.name).to_not eq ""
        expect(response.status).to eq 200
      end
    end
  end

  describe "#create" do
    context "when successfull" do
      it "creates a channel" do
        response = post :create, client_id: client.id, channel: {name: "tom"}
        expect(assigns(:channel)).to be_persisted
        expect(response).to redirect_to(client_channels_path(client))
      end
    end

    context "when failed" do
      it "doesn't redirect" do
        response = post :create, client_id: client.id, channel: {name: ""}
        expect(assigns(:channel)).to_not be_persisted
        expect(response.status).to eq 200
      end
    end
  end

  describe "#destroy" do
    it "destroy a channel" do
      response = delete :destroy, client_id: client.id, id: channel.id
      expect { channel.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to redirect_to(client_channels_path(client))
    end
  end
end
