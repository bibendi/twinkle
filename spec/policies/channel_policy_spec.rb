require "spec_helper"

describe ChannelPolicy do
  subject { described_class }
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:client) { create :client }

  permissions :show? do
    it "grants access for all users" do
      expect(subject).to permit(user, ::Channel)
    end
  end

  permissions :new?, :create?, :edit?, :update?, :destroy? do
    it "denies access for users" do
      expect(subject).to_not permit(user, client)
    end

    it "grants access for admins" do
      expect(subject).to permit(admin, client)
    end
  end
end
