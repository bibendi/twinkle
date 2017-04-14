# frozen_string_literal: true
module Api
  module V1
    class TokensController < ::Api::ApplicationController
      def create
        authorize current_owner, :manage?
        authorize ::User, :create_tokens?

        tokens_context = ::CreateUserTokens.call!(user: current_owner)
        @access_token = tokens_context.access_token.token
        @refresh_token = tokens_context.refresh_token.token
      end

      private

      def authenticate_for(*_args)
        old_token_audience = ::Knock.token_audience
        ::Knock.token_audience = -> { "refresh" }
        super
      ensure
        ::Knock.token_audience = old_token_audience
      end
    end
  end
end
