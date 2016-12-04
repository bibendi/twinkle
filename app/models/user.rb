# frozen_string_literal: true
class User < ActiveRecord::Base
  validates :email, presence: true
  validates :username, presence: true
  validates :role_id, inclusion: {in: Role.all.map(&:id)}

  before_create :generate_remember_token

  def role
    Role.find(role_id)
  end

  Role.all.each do |role|
    define_method "#{role.name}?" do
      role_id >= role.id
    end
  end

  private

  def generate_remember_token
    self.remember_token = SecureRandom.hex(20)
  end
end
