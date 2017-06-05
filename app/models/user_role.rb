# frozen_string_literal: true
class UserRole < ActiveHash::Base
  include ActiveHash::Enum

  self.data = [
    {id: 10, name: "user"},
    {id: 20, name: "admin"}
  ]

  enum_accessor :name

  data.each do |row|
    define_method "#{row[:name]}?" do
      public_send(:id) >= row[:id]
    end
  end
end
