class ChannelTransportPolicy < ApplicationPolicy
  def new?
    user.try(:admin?)
  end

  alias create? new?
  alias destroy? new?
end
