require "spec_helper"

describe Api::V1::ClientsController do
  let(:user) { create :user, :admin }
  let(:client) { create :client }

  before do
    authenticate user
  end

  describe "#index" do
    it "loads all clients" do
      create_list :client, 2
      response = get :index
      expect(response.status).to eq 200
      expect(assigns(:clients).size).to eq 2
    end
  end

  describe "#show" do
    it "find a client" do
      response = get :show, id: client.id
      expect(response.status).to eq 200
      expect(assigns(:client)).to eq client
    end
  end

  describe "#update" do
    context "when successfull" do
      it "updates a client" do
        response = put :update, id: client.id, client: {name: "tom"}
        expect(response.status).to eq 200
        expect(client.reload.name).to eq "tom"
      end
    end

    context "when failed" do
      it "doesn't update a client" do
        response = put :update, id: client.id, client: {name: ""}
        expect(response.status).to eq 422
        expect(client.reload.name).to_not eq ""
      end
    end
  end

  describe "#create" do
    context "when successfull" do
      it "creates a client" do
        response = post :create, client: {name: "tom"}
        expect(response.status).to eq 200
        expect(assigns(:client)).to be_persisted
      end
    end

    context "when failed" do
      it "doesn't create a client" do
        response = post :create, client: {name: ""}
        expect(response.status).to eq 422
        expect(assigns(:client)).to_not be_persisted
      end
    end
  end

  describe "#destroy" do
    it "destroy a client" do
      response = delete :destroy, id: client.id
      expect(response.status).to eq 200
      expect { client.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
