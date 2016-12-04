# frozen_string_literal: true
class GithubAuthorize < ApplicationInteractor
  params :username, :token

  validates :username, :token, presence: true

  private

  def perform
    if !config.organization
      context.role = ::Role::ADMIN
    elsif organization_member?
      teams = github.organization_teams(config.organization)
      raise ArgumentError, "Admin team required" unless config.admin_team.present?
      admin_team = find_team(teams, config.admin_team)

      context.role = team_member?(admin_team) ? ::Role::ADMIN : ::Role::VIEWER
    else
      context.fail!(message: t("errors.messages.not_organization_member"))
    end
  end

  def organization_member?
    github.organization_member?(config.organization, username)
  end

  def find_team(teams, slug)
    teams.find { |t| t.slug == slug }
  end

  def team_member?(team)
    team && github.team_member?(team.id, username)
  end

  def github
    @github ||= Octokit::Client.new(access_token: token)
  end

  def config
    @config ||= Rails.application.config.twinkle.github
  end
end
