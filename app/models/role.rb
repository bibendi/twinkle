# frozen_string_literal: true
class Role < ActiveHash::Base
  include ActiveHash::Enum

  self.data = [
    {id: 0, name: "viewer"},
    {id: 1, name: "admin"}
  ]

  enum_accessor :name
end
