require "spec_helper"

describe GithubAuthorize do
  subject(:context) { described_class.call(username: "tom", token: "qwerty") }

  context "when organization is nil" do
    it "authorizes with any organization" do
      expect(context.role).to eq Role::ADMIN
      expect(context).to be_a_success
    end
  end

  context "when organization is defined" do
    let(:github_api) { instance_double(Octokit::Client) }
    let(:admin_team) { double("team", id: 1, slug: "devops") }

    before do
      Rails.application.config.twinkle.github.organization = "paradise"
      Rails.application.config.twinkle.github.admin_team = "devops"
    end

    after do
      Rails.application.config.twinkle.github.organization = nil
      Rails.application.config.twinkle.github.admin_team = nil
    end

    context "when user in organization" do
      context "when is admin's member" do
        it "authorizes with admin role" do
          expect(github_api).to receive(:organization_member?).with("paradise", "tom").and_return(true)
          expect(github_api).to receive(:organization_teams).with("paradise").and_return([admin_team])
          expect(github_api).to receive(:team_member?).with(admin_team.id, "tom").and_return(true)
          allow(Octokit::Client).to receive(:new).with(access_token: "qwerty").and_return(github_api)

          expect(context.role).to eq Role::ADMIN
          expect(context).to be_a_success
        end
      end

      it "authorizes with viewer role" do
        expect(github_api).to receive(:organization_member?).with("paradise", "tom").and_return(true)
        expect(github_api).to receive(:organization_teams).with("paradise").and_return([])
        allow(Octokit::Client).to receive(:new).with(access_token: "qwerty").and_return(github_api)

        expect(context.role).to eq Role::VIEWER
        expect(context).to be_a_success
      end
    end

    context "when user not in organization" do
      it "fails" do
        expect(github_api).to receive(:organization_member?).with("paradise", "tom").and_return(false)
        allow(Octokit::Client).to receive(:new).with(access_token: "qwerty").and_return(github_api)
        expect(context).to be_a_failure
      end
    end
  end
end
