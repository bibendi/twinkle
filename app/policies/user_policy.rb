class UserPolicy < ApplicationPolicy
  def manage?
    user.admin? || user == object
  end

  def create_tokens?
    user.present?
  end

  def create_api_key?
    user.try(:admin?)
  end

  def show_clients?
    user.present?
  end

  alias create_client? :show_clients?
end
