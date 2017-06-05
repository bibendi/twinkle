# frozen_string_literal: true
module ClientMember
  extend ActiveSupport::Concern

  included do
    extend ActsAsRole
    acts_as_role :client_role

    belongs_to :client

    scope :viewers, -> { where(["role_id >= ?", ClientRole::VIEWER.id]) }
    scope :members, -> { where(["role_id >= ?", ClientRole::MEMBER.id]) }
    scope :owners, -> { where(["role_id >= ?", ClientRole::OWNER.id]) }
  end
end
