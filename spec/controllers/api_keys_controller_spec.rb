require "spec_helper"

describe ApiKeysController do
  let(:admin) { create :user, :admin }
  let(:user) { create :user }

  describe "#new" do
    context "when user is not admin" do
      it "denies access" do
        authenticate user
        response = get :new
        expect(response.status).to eq 403
        expect(assigns(:token)).to_not be_present
      end
    end

    context "when user is admin" do
      before { authenticate admin }

      it "requires expire_at greater then now" do
        response = get :new, expire_at: 1.day.ago.rfc2822
        expect(response.status).to eq 302
        expect(assigns(:token)).to_not be_present
      end

      it "creates a token" do
        response = get :new, expire_at: 1.week.since.rfc2822
        expect(response.status).to eq 200
        expect(assigns(:token)).to be_present
      end
    end
  end
end
