# frozen_string_literal: true
class UserTeamsFinder
  include Findit::Collections

  def initialize(user, org:)
    @user = user
    @org = org
  end

  private

  def find
    scope = Team.where(org_id: @org.id)
    teams = scope.where(name: nil).to_a

    org_teams = @user.api.org_teams(@org.name)
    teams += scope.where(name: org_teams.map(&:name)).to_a
  end
end
