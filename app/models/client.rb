# frozen_string_literal: true
class Client < ActiveRecord::Base
  has_many :channels
  has_many :transports

  has_many :client_users
  has_many :users, through: :client_users

  has_many :client_teams
  has_many :teams, through: :client_teams

  validates :name, presence: true
  validates :token, presence: true, uniqueness: true

  before_validation :generate_token, on: :create

  private

  def generate_token
    self.token ||= SecureRandom.uuid
  end
end
