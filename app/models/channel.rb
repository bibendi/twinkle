class Channel < ActiveRecord::Base
  belongs_to :user, required: true

  has_many :channel_transports
  has_many :transports, through: :channel_transports

  validates :name, presence: true, uniqueness: {scope: :user_id}
end
