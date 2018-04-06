# frozen_string_literal: true
class UserApiClient
  def initialize(username:, token:)
    @username = username
    @adapter = Octokit::Client.new(access_token: token)
  end

  delegate :orgs, :org_teams, to: "@adapter"

  def org_member?(org_name)
    @adapter.organization_member?(org_name, @username)
  end

  def team_member?(org_name, team_name)
    teams = org_teams(org_name)
    team = teams.find { |t| t.slug == team_name }
    @adapter.team_member?(team.id, @username)
  end
end
