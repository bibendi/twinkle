class Transport < ActiveRecord::Base
  belongs_to :client, required: true

  has_many :channel_transports
  has_many :channels, through: :channel_transports

  scope :telegrams, -> { where(type: "Transports::Telegram") }
end
