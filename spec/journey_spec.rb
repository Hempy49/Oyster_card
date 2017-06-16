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
end
