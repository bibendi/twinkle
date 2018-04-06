# frozen_string_literal: true
class User < ActiveRecord::Base
  extend ActsAsRole
  acts_as_role :user_role

  has_many :client_users
  has_many :clients, through: :client_users

  validates :email, presence: true
  validates :username, presence: true

  def api
    @api ||= UserApi.new(username: username, token: github_token)
  end
end
