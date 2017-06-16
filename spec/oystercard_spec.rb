require 'oystercard'

describe Oystercard do

  let(:station)      { double(:kings_cross) }
  let(:exit_station) { double(:waterloo) }
  let(:max_limit)    { described_class::MAX_LIMIT }
  let(:min_fare)     { described_class::MIN_FARE }

  let(:journey) do
    journey = double(:journey)
    allow(journey).to receive(:start)
    allow(journey).to receive(:finish)
    allow(journey).to receive(:exit_station) { exit_station }
    allow(journey).to receive(:incomplete?)  { true }
    allow(journey).to receive(:fare)         { 1 }
    journey
  end

  it { is_expected.to respond_to(:topup).with(1).argument }
  it { is_expected.to respond_to(:touch_in).with(1).argument }
  it { is_expected.to respond_to(:touch_out).with(1).argument }
  it { is_expected.to respond_to(:previous_journeys)}
  it { is_expected.to respond_to(:journey) }

  describe "#balance" do
    it "should return the balance of the card" do
      expect(subject.balance).to eq(0)
    end
  end

  describe "#topup" do
    it "should add a specified amount to the balance" do
      expect { subject.topup 10 }.to change { subject.balance }.by 10
    end

    context "new balance would exceed the limit" do
      it "should raise an error" do
        subject.topup max_limit
        expect { subject.topup(1) }.to raise_error("You have reached your maximum balance limit")
      end
    end
  end

  describe "#touch_in" do
    context "starting journey" do
      before do
        subject.topup(min_fare)
        subject.touch_in(station, journey)
      end
    end

    context "Not enough money on card" do
      it "should raise an error" do
        expect { subject.touch_in(station) }.to raise_error("Please top up")
      end
    end
  end

  describe "#touch_out" do
    context "finishing journey" do
      before do
        subject.topup(min_fare)
        subject.touch_in(station, journey)
        subject.touch_out(exit_station)
      end

      it "records the journey" do
        expect(subject.journey.exit_station).to eq exit_station
      end
    end

    context "after journey" do
      it "should deduct my balance by the fare amount" do
        subject.topup(min_fare)
        subject.touch_in(station, journey)
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by -min_fare
      end
    end
  end
end
