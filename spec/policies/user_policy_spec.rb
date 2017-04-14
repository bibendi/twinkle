require "spec_helper"

describe UserPolicy do
  subject { described_class }
  let(:user) { create :user }
  let(:other_user) { create :user }
  let(:admin) { create :user, :admin }

  permissions :create_tokens?, :show_clients? do
    it "grants access for all users" do
      expect(subject).to permit(user, ::User)
    end
  end

  permissions :manage? do
    it "denies access for other users" do
      expect(subject).to_not permit(user, other_user)
    end

    it "grants access for owners" do
      expect(subject).to permit(user, user)
    end

    it "grants access for admins" do
      expect(subject).to permit(admin, user)
    end
  end

  permissions :create_api_key? do
    it "denies access for users" do
      expect(subject).to_not permit(user, ::User)
    end

    it "grants access for admins" do
      expect(subject).to permit(admin, ::User)
    end
  end
end
