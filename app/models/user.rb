# frozen_string_literal: true
class User < ActiveRecord::Base
  validates :email, presence: true
  validates :username, presence: true
  validates :role_id, inclusion: {in: Role.all.map(&:id)}

  Role.all.each do |role|
    define_method "#{role.name}?" do
      role_id >= role.id
    end
  end
end
