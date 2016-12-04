# frozen_string_literal: true
class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:create]
  skip_before_action :authorize, only: [:destroy]

  def create
    authorize_context = GithubAuthorize.call(username: github_username, token: github_token)

    if authorize_context.success?
      user = find_user || create_user
      update_user_role(user, authorize_context.role)
      create_session_for(user)
      flash[:notice] = "You have been logged in."
    else
      flash[:error] = authorize_context.message
    end

    redirect_to root_path
  end

  def destroy
    destroy_session
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

  def create_session_for(user)
    session[:remember_token] = user.remember_token
  end

  def destroy_session
    session[:remember_token] = nil
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
