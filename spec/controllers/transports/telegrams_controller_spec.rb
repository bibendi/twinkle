require "spec_helper"

describe Transports::TelegramsController do
  let(:user) { create :user, :admin }
  let(:client) { create :client }
  let(:telegram) { create :telegram_transport, client: client }

  before do
    authenticate user
  end

  describe "#index" do
    it "loads client's telegrams" do
      create_list :telegram_transport, 2, client: client
      response = get :index, client_id: client.id
      expect(response.status).to eq 200
      expect(assigns(:telegrams).size).to eq 2
    end
  end

  describe "#show" do
    it "find a telegram" do
      response = get :show, client_id: client.id, id: telegram.id
      expect(response.status).to eq 200
      expect(assigns(:telegram)).to eq telegram
    end
  end

  describe "#new" do
    it "build a telegram" do
      response = get :new, client_id: client.id
      expect(response.status).to eq 200
      expect(assigns(:telegram)).to_not be_persisted
    end
  end

  describe "#edit" do
    it "find a telegram" do
      response = get :edit, client_id: client.id, id: telegram.id
      expect(response.status).to eq 200
      expect(assigns(:telegram)).to eq telegram
    end
  end

  describe "#update" do
    context "when successfull" do
      it "updates a telegram" do
        response = put :update, client_id: client.id, id: telegram.id, telegram: {chat_name: "deploy", chat_id: 123}
        expect(response).to redirect_to(client_transports_telegrams_path(client))
        expect(telegram.reload.name).to eq "deploy"
      end
    end

    context "when failed" do
      it "doesn't redirect" do
        response = put :update, client_id: client.id, id: telegram.id, telegram: {chat_name: ""}
        expect(response.status).to eq 200
        expect(telegram.reload.name).to_not eq ""
      end
    end
  end

  describe "#create" do
    context "when successfull" do
      it "creates a telegram" do
        response = post :create, client_id: client.id, telegram: {chat_name: "deploy", chat_id: 123}
        expect(response).to redirect_to(client_transports_telegrams_path(client))
        expect(assigns(:telegram)).to be_persisted
      end
    end

    context "when failed" do
      it "doesn't redirect" do
        response = post :create, client_id: client.id, telegram: {chat_name: ""}
        expect(response.status).to eq 200
        expect(assigns(:telegram)).to_not be_persisted
      end
    end
  end

  describe "#destroy" do
    it "destroy a telegram" do
      response = delete :destroy, client_id: client.id, id: telegram.id
      expect(response).to redirect_to(client_transports_telegrams_path(client))
      expect { telegram.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
