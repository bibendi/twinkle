# frozen_string_literal: true
module Authorizable
  extend ::ActiveSupport::Concern
  include ::Knock::Authenticable
  include ::Pundit

  included do
    before_action :authenticate_user
    after_action :verify_authorized
  end

  private

  def token
    super || session[:token]
  end

  def signed_in?
    !!current_user
  end

  def current_owner
    @current_owner ||= params[:user_id] ? User.find(params[:user_id].to_i) : current_user
  end
end
