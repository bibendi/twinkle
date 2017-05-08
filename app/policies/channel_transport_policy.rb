class ChannelTransportPolicy < ApplicationPolicy
  def edit?
    return false unless object.client
    ClientPolicy.new(user, object.client).edit?
  end

  alias update? edit?
  alias destroy? edit?
end
