require "spec_helper"

describe ChannelTransportPolicy do
  subject { described_class }
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:client) { create :client }

  permissions :create?, :create?, :destroy? do
    it "denies access for users" do
      expect(subject).to_not permit(user, client)
    end

    it "grants access for admins" do
      expect(subject).to permit(admin, client)
    end
  end
end
