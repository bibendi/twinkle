require "spec_helper"

describe ClientPolicy do
  subject { described_class }
  let(:user) { create :user }
  let(:client) { create :client }

  permissions :index?, :new?, :create? do
    it "grants access for all users" do
      expect(subject).to permit(user, ::Client)
    end
  end

  permissions :edit?, :update?, :destroy? do
    it "denies access for viewers" do
      expect(subject).to_not permit(user, client)
    end

    it "grants access for admins" do
      expect(subject).to permit(admin, client)
    end
  end
end
