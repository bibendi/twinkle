require "spec_helper"

describe User do
  it "generates token after create" do
    user = User.create!(name: "username")
    expect(user.token).to be_present
  end
end
