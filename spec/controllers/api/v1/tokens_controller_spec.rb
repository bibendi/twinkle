require "spec_helper"

describe Api::V1::TokensController do
  let(:user) { create :user }
  let(:other_user) { create :user }

  describe "#create" do
    context "when not authenticated" do
      it "responds unauthorized" do
        response = post :create
        expect(response.status).to eq 401
      end
    end

    context "when authenticated not by refresh token" do
      it "responds unauthorized" do
        authenticate user
        response = post :create
        expect(response.status).to eq 401
      end
    end

    context "when authenticated by refresh token" do
      before { authenticate user, aud: "refresh" }

      context "when current user is owner" do
        it "generates tokens" do
          response = post :create
          expect(response.status).to eq 200
          expect(assigns(:access_token)).to be_present
          expect(assigns(:refresh_token)).to be_present
        end
      end

      context "when current user is not owner" do
        it "responds forbidden" do
          response = post :create, user_id: other_user.id
          expect(response.status).to eq 403
        end

        context "when is admin" do
          let(:user) { create :user, :admin }

          it "generates tokens" do
            response = post :create, user_id: other_user.id
            expect(response.status).to eq 200
            expect(assigns(:access_token)).to be_present
            expect(assigns(:refresh_token)).to be_present
          end
        end
      end
    end
  end
end
