# frozen_string_literal: true
class ClientUser < ActiveRecord::Base
  include ClientMember

  belongs_to :user, required: true

  validates :user_id, uniqueness: {scope: :client_id}

  def username
    user.try(:username)
  end

  def username=(value)
    self.user = User.find_by(username: value)
  end

  def to_param
    username
  end
end
