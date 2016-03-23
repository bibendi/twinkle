class ChannelTransport < ActiveRecord::Base
  belongs_to :channel, required: true
  belongs_to :transport, required: true
end
