require "spec_helper"

describe AuthenticateUser do
  let(:user) { create :user }

  let(:context) { described_class.call(token: token) }

  context "when given valid credentials" do
    let(:token) { user.token }

    it "succeeds" do
      expect(context).to be_a_success
    end
  end

  context "when given invalid credentials" do
    let(:token) { "bad" }

    it "fails" do
      expect(context).to be_a_failure
    end
  end
end
