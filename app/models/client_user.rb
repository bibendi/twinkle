# frozen_string_literal: true
class ClientUser < ActiveRecord::Base
  include ClientOwner

  belongs_to :user

  validates :user_id, uniqueness: {scope: :client_id}
end
