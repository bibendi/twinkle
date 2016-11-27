require "spec_helper"

describe Transports::Telegram do
  it "returns name of chat" do
    telegram = build :telegram_transport
    expect(telegram.name).to eq telegram.chat_name
  end
end
