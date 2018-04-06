require "spec_helper"

describe ProfilesController do
  let(:user) { create :user, :admin }

  before do
    authenticate user
  end

  describe "#show" do
    it "show the current_user" do
      response = get :show
      expect(response.status).to eq 200
      expect(assigns(:user)).to eq user
    end
  end
end
