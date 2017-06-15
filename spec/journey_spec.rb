require 'Journey'

describe Journey do

  let(:station) { double(:Waterloo) }
  let(:exit_station) { double(:Aldgate) }
  let(:journey) { described_class.new(station) }

  describe "#entry_station" do
    it "should return the entry station" do
      expect(journey.entry_station).to eq(station)
    end
  end

  describe "#record_journey" do
    it "should create a journey record upon touch_out" do
      expect(journey.record_journey(station, exit_station)).to eq({ entry: station, exit: exit_station} )
    end
  end


end
