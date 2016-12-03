require "spec_helper"

describe ChannelsController do
  let(:user) { create :user }
  let(:client) { create :client }
  let(:channel) { create :channel, client: client }

  before do
    authenticate user
    authorize :admin
  end

  describe "#index" do
    it "loads client's channels" do
      create_list :channel, 2, client: client
      response = get :index, client_id: client.id
      expect(response.status).to eq 200
      expect(assigns(:channels).size).to eq 2
    end
  end

  describe "#show" do
    it "find a channel" do
      response = get :show, client_id: client.id, id: channel.id
      expect(response.status).to eq 200
      expect(assigns(:channel)).to eq channel
    end
  end

  describe "#new" do
    it "build a channel" do
      response = get :new, client_id: client.id
      expect(response.status).to eq 200
      expect(assigns(:channel)).to_not be_persisted
    end
  end

  describe "#edit" do
    it "find a channel" do
      response = get :edit, client_id: client.id, id: channel.id
      expect(response.status).to eq 200
      expect(assigns(:channel)).to eq channel
    end
  end

  describe "#update" do
    context "when successfull" do
      it "updates a channel" do
        response = put :update, client_id: client.id, id: channel.id, channel: {name: "deploy"}
        expect(response).to redirect_to(client_channels_path(client))
        expect(channel.reload.name).to eq "deploy"
      end
    end

    context "when failed" do
      it "doesn't redirect" do
        response = put :update, client_id: client.id, id: channel.id, channel: {name: ""}
        expect(response.status).to eq 200
        expect(channel.reload.name).to_not eq ""
      end
    end
  end

  describe "#create" do
    context "when successfull" do
      it "creates a channel" do
        response = post :create, client_id: client.id, channel: {name: "tom"}
        expect(response).to redirect_to(client_channels_path(client))
        expect(assigns(:channel)).to be_persisted
      end
    end

    context "when failed" do
      it "doesn't redirect" do
        response = post :create, client_id: client.id, channel: {name: ""}
        expect(response.status).to eq 200
        expect(assigns(:channel)).to_not be_persisted
      end
    end
  end

  describe "#destroy" do
    it "destroy a channel" do
      response = delete :destroy, client_id: client.id, id: channel.id
      expect(response).to redirect_to(client_channels_path(client))
      expect { channel.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
