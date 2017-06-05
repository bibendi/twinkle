class ClientUserPolicy < ApplicationPolicy
  def show?
    return false unless object.client
    ClientPolicy.new(user, object.client).show?
  end

  def edit?
    return false unless object.client
    ClientPolicy.new(user, object.client).create_member?
  end

  alias update? edit?

  def destroy?
    return false unless object.client

    # Owner of a Client can't self delete
    if user == object.user
      return object.role.viewer? || object.role.member?
    end

    edit?
  end
end
