# frozen_string_literal: true
class Team < ActiveRecord::Base
  belongs_to :org
  has_many :client_teams
  has_many :clients, through: :client_teams

  validates :name, uniqueness: {case_sensitive: false, scope: :org_id}

  def name=(value)
    self[:name] = value.presence
  end

  # Default team
  # Any user of organization
  def default?
    !name?
  end
end
