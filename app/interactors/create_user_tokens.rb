# frozen_string_literal: true
class CreateUserTokens < ApplicationInteractor
  params :user

  validates :user, presence: true

  private

  def perform
    context.access_token = ::Knock::AuthToken.new(payload: access_token_claims)
    context.refresh_token = ::Knock::AuthToken.new(payload: refresh_token_claims)
  end

  def access_token_claims
    {sub: user.id}
  end

  def refresh_token_claims
    {
      sub: user.id,
      exp: Rails.application.config.refresh_token_lifetime.from_now.to_i,
      aud: "refresh"
    }
  end
end
