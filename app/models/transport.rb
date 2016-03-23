class Transport < ActiveRecord::Base
  belongs_to :user, required: true

  has_many :channel_transports
  has_many :channels, through: :channel_transports
end
