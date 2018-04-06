module Transports
  class TelegramPolicy < ApplicationPolicy
    def show?
      return false unless object.client
      ClientPolicy.new(user, object.client).show?
    end

    def edit?
      return false unless object.client
      ClientPolicy.new(user, object.client).edit?
    end

    alias update? edit?
    alias destroy? edit?
  end
end
