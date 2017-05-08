# frozen_string_literal: true
class ClientRole < ActiveHash::Base
  include ActiveHash::Enum

  self.data = [
    {id: 10, name: "viewer"},
    {id: 20, name: "member"},
    {id: 30, name: "owner"}
  ]

  enum_accessor :name
end
