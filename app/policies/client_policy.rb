class ClientPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  alias show? index?

  def new?
    user.try(:admin?)
  end

  alias create? new?
  alias edit? new?
  alias update? new?
  alias destroy? new?

  def show_channels?
    user.present?
  end

  def show_transports?
    user.present?
  end
end
