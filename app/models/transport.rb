class Transport < Ohm::Model
  include Ohm::DataTypes

  attribute :name
  attribute :options, Type::Hash

  reference :channel, :Channel
end
