# frozen_string_literal: true
class UserRole < ActiveHash::Base
  include ActiveHash::Enum

  self.data = [
    {id: 10, name: "user"},
    {id: 20, name: "admin"}
  ]

  enum_accessor :name
end
