require "spec_helper"

describe Client do
  it "generates token after create" do
    client = Client.create!(name: "clientname")
    expect(client.token).to be_present
  end
end
