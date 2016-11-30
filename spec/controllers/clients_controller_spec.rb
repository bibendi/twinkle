require "spec_helper"

describe ClientsController do
  let(:user) { create :user }
  let(:client) { create :client }

  before { authenticate(user) }

  describe "#index" do
    it "loads all clients" do
      create_list :client, 2
      response = get :index
      expect(assigns(:clients).size).to eq 2
      expect(response.status).to eq 200
    end
  end

  describe "#show" do
    it "find a client" do
      response = get :show, id: client.id
      expect(assigns(:client)).to eq client
      expect(response.status).to eq 200
    end
  end

  describe "#new" do
    it "build a client" do
      response = get :new
      expect(assigns(:client)).to_not be_persisted
      expect(response.status).to eq 200
    end
  end

  describe "#edit" do
    it "find a client" do
      response = get :edit, id: client.id
      expect(assigns(:client)).to eq client
      expect(response.status).to eq 200
    end
  end

  describe "#update" do
    context "when successfull" do
      it "updates a client" do
        response = put :update, id: client.id, client: {name: "tom"}
        expect(client.reload.name).to eq "tom"
        expect(response).to redirect_to(clients_path)
      end
    end

    context "when failed" do
      it "doesn't redirect" do
        response = put :update, id: client.id, client: {name: ""}
        expect(client.reload.name).to_not eq ""
        expect(response.status).to eq 200
      end
    end
  end

  describe "#create" do
    context "when successfull" do
      it "creates a client" do
        response = post :create, client: {name: "tom"}
        expect(assigns(:client)).to be_persisted
        expect(response).to redirect_to(clients_path)
      end
    end

    context "when failed" do
      it "doesn't redirect" do
        response = post :create, client: {name: ""}
        expect(assigns(:client)).to_not be_persisted
        expect(response.status).to eq 200
      end
    end
  end

  describe "#destroy" do
    it "destroy a client" do
      response = delete :destroy, id: client.id
      expect { client.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to redirect_to(clients_path)
    end
  end
end
