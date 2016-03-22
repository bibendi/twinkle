class Channel < Ohm::Model
  attribute :name
  unique :name
  index :name

  collection :transports, :Transport
end
