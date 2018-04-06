# frozen_string_literal: true
class ApplicationController < ActionController::Base
  include ::Authorizable
  include ::Responsable

  protect_from_forgery with: :exception

  helper_method :current_user,
                :signed_in?
end
