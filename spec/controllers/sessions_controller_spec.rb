require "spec_helper"

describe SessionsController do
  context "when sign in" do
    def build_auth_env
      request.env["omniauth.auth"] = OmniAuth::AuthHash.new(info: {nickname: "tom", email: "tom@ex.com"},
                                                            credentials: {token: "qwerty"})
    end

    context "when authorization failed" do
      it "doesn't create a session" do
        context = double(:context, success?: false, message: "error")
        expect(GithubAuthorize).to receive(:call).and_return(context)

        build_auth_env

        response = post :create

        expect(controller.session[:remember_token]).to be_nil
        expect(response).to redirect_to(root_path)
      end
    end

    context "when authorization successfull" do
      before do
        context = double(:context, success?: true, role: Role::ADMIN)
        expect(GithubAuthorize).to receive(:call).and_return(context)

        build_auth_env
      end

      context "when user doesn't exists" do
        it "creates user and session" do
          response = post :create
          expect(response).to redirect_to(root_path)

          user = User.first
          expect(user.email).to eq "tom@ex.com"
          expect(user.username).to eq "tom"

          expect(controller.session[:remember_token]).to be_present
        end
      end

      context "when user already exists" do
        it "find user and create session" do
          user = create :user, username: "tom", email: "tom@ex.com"
          response = post :create
          expect(response).to redirect_to(root_path)
          expect(User.count).to eq 1
          expect(controller.session[:remember_token]).to be_present
        end
      end
    end
  end

  context "when sign out" do
    it "destroy a session" do
      user = create :user
      controller.session[:remember_token] = user.remember_token
      response = delete :destroy
      expect(response).to redirect_to(root_path)
      expect(controller.session[:remember_token]).to be_nil
    end
  end
end
