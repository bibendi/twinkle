class GithubAuthorize < ApplicationInteractor
  params :username, :token

  validates :username, :token, presence: true

  private

  def perform
    return unless config.organization

    context.fail!(message: t("errors.messages.not_organization_member")) unless organization_member?
  end

  def organization_member?
    github.organization_member?(config.organization, username)
  end

  def github
    @github ||= Octokit::Client.new(access_token: token)
  end

  def config
    @config ||= Rails.application.config.twinkle.github
  end
end
