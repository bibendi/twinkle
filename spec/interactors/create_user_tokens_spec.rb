require "spec_helper"

describe CreateUserTokens do
  let(:user) { create :user }
  subject(:context) { described_class.call(user: user) }

  it "create access tokens" do
    expect(context.access_token).to be_present
    expect(context.refresh_token).to be_present
  end
end
