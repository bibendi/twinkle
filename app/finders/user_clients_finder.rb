# frozen_string_literal: true
class UserClientsFinder
  include Findit::Collections

  delegate :github, to: :@user

  def initialize(user, role: nil)
    @user = user
    @role = role
  end

  private

  def find
    client_users = @user.client_users
    client_users = client_users.members if @role == ClientRole::MEMBER
    clients = client_users.includes(:client).map(&:client)

    orgs = UserOrgsFinder.new(@user).to_a
    orgs.each do |org|
      teams = UserTeamsFinder.new(@user, org: org).to_a
      client_teams = ClientTeam.where(team_id: teams.map(&:id))
      client_teams = client_teams.members if @role == ClientRole::MEMBER
      clients += client_teams.includes(:client).map(&:client)
    end

    clients.uniq
  end
end
