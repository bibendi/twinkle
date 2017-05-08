# frozen_string_literal: true
class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    skip_authorization

    user = find_user || build_user

    if config.github.organization
      authorize_context = GithubAuthorize.call(
        user: user,
        organization: config.github.organization,
        team: config.github.admin_team
      )

      unless authorize_context.success?
        respond_to do |format|
          format.html do
            redirect_to root_path, error: authorize_context.message
          end

          format.json do
            render json: {error: authorize_context.message}, status: 403
          end
        end

        return
      end
    end

    unless save_user(user)
      respond_to do |format|
        format.html do
          redirect_to root_path, error: user.errors.full_messages.to_s
        end

        format.json do
          render json: {error: user.errors.full_messages}, status: 422
        end
      end

      return
    end

    tokens_context = ::CreateUserTokens.call!(user: user)

    respond_to do |format|
      format.html do
        session[:token] = tokens_context.access_token.token
        redirect_to root_path, notice: "You have been logged in."
      end

      format.json do
        render json: {access_token: tokens_context.access_token.token,
                      refresh_token: tokens_context.refresh_token.token}
      end
    end
  end

  def destroy
    skip_authorization
    session[:token] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end

  private

  def find_user
    User.find_by(username: github_username)
  end

  def build_user
    User.new(
      email: github_email_address,
      username: github_username,
      github_token: github_token,
      role: User.exist? ? UserRole::USER : UserRole::ADMIN
    )
  end

  def save_user(user)
    user.github_token = github_token
    user.save
  end

  def auth_hash
    @auth_hash ||= request.env['omniauth.auth']
  end

  def github_username
    @github_username ||= auth_hash.info.nickname
  end

  def github_email_address
    @github_email_address ||= auth_hash.info.email
  end

  def github_token
    @github_token ||= auth_hash.credentials.token
  end

  def config
    @config ||= Rails.application.config.twinkle
  end
end
