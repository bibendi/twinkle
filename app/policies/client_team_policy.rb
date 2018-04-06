class ClientTeamPolicy < ApplicationPolicy
  def show?
    return false unless object.client
    ClientPolicy.new(user, object.client).show?
  end

  def edit?
    return false unless object.client
    ClientPolicy.new(user, object.client).create_member?
  end

  alias update? edit?
  alias destroy? edit?
end
