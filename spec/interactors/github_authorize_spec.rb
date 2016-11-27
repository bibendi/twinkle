require "spec_helper"

describe GithubAuthorize do
  subject(:context) { described_class.call(username: "tom", token: "qwerty") }

  context "when organization is nil" do
    it "authorizes with any organization" do
      expect(context).to be_a_success
    end
  end

  context "when user in organization" do
    it "authorizes" do
      Rails.application.config.twinkle.github.organization = "paradise"

      github_api = instance_double(Octokit::Client)
      expect(github_api).to receive(:organization_member?).with("paradise", "tom").and_return(true)
      expect(Octokit::Client).to receive(:new).with(access_token: "qwerty").and_return(github_api)

      expect(context).to be_a_success

      Rails.application.config.twinkle.github.organization = nil
    end
  end

  context "when user not in organization" do
    it "fails" do
      Rails.application.config.twinkle.github.organization = "paradise"

      github_api = instance_double(Octokit::Client)
      expect(github_api).to receive(:organization_member?).with("paradise", "tom").and_return(false)
      expect(Octokit::Client).to receive(:new).with(access_token: "qwerty").and_return(github_api)

      expect(context).to be_a_failure

      Rails.application.config.twinkle.github.organization = nil
    end
  end
end
