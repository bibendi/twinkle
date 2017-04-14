class ChannelPolicy < ApplicationPolicy
  def show?
    user.present?
  end

  def new?
    user.try(:admin?)
  end

  alias create? new?
  alias edit? new?
  alias update? new?
  alias destroy? new?
end
