# frozen_string_literal: true
module ClientOwner
  extend ActiveSupport::Concern

  included do
    extend ActsAsRole
    acts_as_role :client_role

    belongs_to :client

    scope :members, -> { where(["role_id >= ?", ClientRole::MEMBER.id]) }
  end
end
