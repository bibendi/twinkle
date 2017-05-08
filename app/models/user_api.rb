# frozen_string_literal: true
class UserApi
  def initialize(username:, token:)
    @username = username
    @client = UserApiClient.new(username: username, token: token)
    @memo = {}
  end

  [:orgs, :org_teams, :org_member?, :team_member?].each do |name|
    define_method(name) do |*args|
      return @memo[name] if @memo.key?(name)

      @memo[name] = cache(name, *args) do
        @client.send(name, *args)
      end
    end
  end

  private

  def cache(*args)
    key = ActiveSupport::Cache.expand_cache_key(args)
    Rails.cache.fetch("user_api/#{@username}/#{key}", cache_options) { yield }
  end

  def cache_options
    @cache_options ||= {
      tags: {username: @username},
      expires_in: 6.hours
    }
  end
end
