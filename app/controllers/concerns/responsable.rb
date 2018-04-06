# frozen_string_literal: true
module Responsable
  extend ActiveSupport::Concern

  included do
    unless Rails.env.development?
      rescue_from "Exception", with: :server_error unless Rails.env.test?
      rescue_from "ActiveRecord::RecordNotFound", with: :not_found
      rescue_from "ActionController::ParameterMissing", with: :bad_request
      rescue_from "Pundit::NotAuthorizedError", with: :forbidden
    end
  end

  private

  def not_found(exception = nil)
    render_error(404, exception)
  end

  def server_error(exception = nil)
    render_error(500, exception)
  end

  def unauthorized(exception = nil)
    render_error(401, exception)
  end

  def forbidden(exception = nil)
    render_error(403, exception)
  end

  def bad_request(exception = nil)
    render_error(400, exception)
  end

  def render_error(status, exception = nil)
    @last_error = status.to_s
    @exception = exception

    respond_to do |format|
      format.html { render "errors/error_#{status}", status: status }
      format.json { render "api/errors/error_#{status}", status: status }
      format.all { render nothing: true, status: status }
    end
  end
end
