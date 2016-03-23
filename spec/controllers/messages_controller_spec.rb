require "spec_helper"

describe MessagesController do
  it "returns 400 when token is invalid" do
    post :create, token: "bad"
    expect(response.status).to eq 400
  end

  it "returns 200 when koen is valid" do
    expect(Resque).to receive(:enqueue).with(SendMessageJob, "deploy", "success")
    post :create, token: ENV["SECRET_TOKEN"], channel: "deploy", message: "success"
    expect(response.status).to eq 200
  end
end
