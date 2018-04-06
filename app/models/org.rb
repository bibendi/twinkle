# frozen_string_literal: true
class Org < ActiveRecord::Base
  validates :name, uniqueness: {case_sensitive: false}
end
