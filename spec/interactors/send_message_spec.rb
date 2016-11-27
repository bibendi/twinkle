require "spec_helper"

describe SendMessage do
  let(:client) { create :client }
  let(:channel) { create :channel, client: client }

  let(:context) { described_class.call(channel: channel, message: "msg") }

  context "when client is inactive" do
    let(:client) { create :client, active: false }

    it "doesn't send message" do
      expect(context).to be_a_success
      expect(context.sent_count).to be_nil
    end
  end

  context "when channel is inactive" do
    let(:channel) { create :channel, client: client, active: false }

    it "doesn't send message" do
      expect(context).to be_a_success
      expect(context.sent_count).to be_nil
    end
  end

  context "when channel has no transports" do
    it "doesn't send message" do
      expect(context).to be_a_success
      expect(context.sent_count).to be_zero
    end
  end

  context "when channel has a transport" do
    let(:telegram) { create :telegram_transport, client: client, channel: channel }

    context "when sending is failure" do
      it "doesn't send message" do
        expect(telegram).to receive(:deliver).with("msg").and_raise("failed")

        expect(context).to be_a_failure
        expect(context.sent_count).to be_zero
        expect(context.message).to eq "failed"
      end
    end

    context "when forwarder is success" do
      context "when interpolating vars" do
        let(:context) { described_class.call(channel: channel, message: "msg %{a.b}", vars: {"a" => {"b" => 1}}) }

        it "sends a message" do
          expect(telegram).to receive(:deliver).with("msg 1")

          expect(context).to be_a_success
          expect(context.sent_count).to eq 1
        end
      end

      context "when no vars" do
        it "sends a message" do
          expect(telegram).to receive(:deliver).with("msg")

          expect(context).to be_a_success
          expect(context.sent_count).to eq 1
        end
      end
    end
  end
end
