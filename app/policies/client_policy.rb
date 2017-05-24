class ClientPolicy < ApplicationPolicy
  def show?
    return false unless user
    return false unless object.try(:persisted?)
    UserClientsFinder.new(user, role: ClientRole::VIEWER).to_a.include?(object)
  end

  alias show_channels? show?
  alias show_transports? show?

  def edit?
    return false unless user
    return false unless object.try(:persisted?)
    UserClientsFinder.new(user, role: ClientRole::MEMBER).to_a.include?(object)
  end

  alias update? edit?
  alias destroy? edit?
  alias create_channel? edit?
  alias create_transport? edit?
end