# frozen_string_literal: true
class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    skip_authorization
    authorize_context = GithubAuthorize.call(username: github_username, token: github_token)

    if authorize_context.success?
      user = find_user || create_user
      update_user_role(user, authorize_context.role)

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
    else
      respond_to do |format|
        format.html do
          redirect_to root_path, error: authorize_context.message
        end

        format.json do
          render json: {error: authorize_context.message}, status: 422
        end
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

  def create_user
    User.create!(
      email: github_email_address,
      username: github_username
    )
  end

  def update_user_role(user, role)
    return if user.role_id == role.id

    user.role_id = role.id
    user.save!
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def github_username
    auth_hash.info.nickname
  end

  def github_email_address
    auth_hash.info.email
  end

  def github_token
    auth_hash.credentials.token
  end
end
