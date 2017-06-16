require 'journey'

describe Journey do

  let(:station)      { double(:Waterloo) }
  let(:exit_station) { double(:Aldgate) }
  let(:journey)      { described_class.new }

  describe "#start" do
    it "should record the entry station" do
      expect(journey.start(station)).to eq station
    end
  end

  describe "#finish" do
   it "should record the exit station" do
     expect(journey.finish(exit_station)).to eq exit_station
   end
  end

  describe "#incomplete?" do
    it "returns false if a journey has been completed" do
      journey.start(station)
      journey.finish(station)
      expect(journey.incomplete?).to eq false
    end
  end

  describe "#fare" do
    before do
      journey.start(station)
    end

    it "returns 1 for a complete journey" do
      journey.finish(station)
      expect(journey.fare).to eq 1
    end

    it "returns 6 for an incomplete journey" do
      expect(journey.fare).to eq 6
    end
  end
end
