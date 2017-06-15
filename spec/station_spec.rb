require 'Station'

describe Station do

  let(:station) {described_class.new(name: "aldgate", zone: 1)}

  describe "#zone" do
    it "returns the zone that the station belongs to" do
      expect(station.zone).to eq(1)
    end
  end

  describe "#name" do
    it "returns the name of the station" do
      expect(station.name).to eq("aldgate")
    end
  end


end
