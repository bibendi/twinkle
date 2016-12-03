# frozen_string_literal: true
class ApplicationController < ActionController::Base
  EDIT_ACTIONS = %w(new edit create update destroy).freeze

  protect_from_forgery with: :exception

  unless Rails.env.development?
    rescue_from "Exception", with: :server_error unless Rails.env.test?
    rescue_from "ActiveRecord::RecordNotFound", with: :not_found
    rescue_from "ActionController::ParameterMissing", with: :bad_request
  end

  before_action :authenticate
  before_action :authorize, if: :signed_in?

  helper_method :current_user,
                :signed_in?

  private

  def authenticate
    unauthorized unless signed_in?
  end

  def authorize
    return if current_user.admin?
    forbidden if EDIT_ACTIONS.include?(action_name)
  end

  def signed_in?
    current_user.present?
  end

  def current_user
    return if session[:remember_token].blank?
    @current_user ||= User.find_by(remember_token: session[:remember_token])
  end

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
      format.all { render nothing: true, status: status }
    end
  end
end
