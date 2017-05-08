# frozen_string_literal: true
class ClientTeam < ActiveRecord::Base
  include ClientOwner

  belongs_to :team

  validates :team_id, uniqueness: {scope: :client_id}
end
