require "spec_helper"

describe RootsController do
  it "returns 200" do
    get :show
    expect(response.status).to eq 200
  end
end
