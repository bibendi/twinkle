# frozen_string_literal: true
class UserOrgsFinder < ApplicationFinder
  collections memoize: true

  cache_key { @user }

  def initialize(user)
    @user = user
  end

  private

  def find
    Org.where(name: @user.api.orgs.map(&:login)).to_a
  end
end
