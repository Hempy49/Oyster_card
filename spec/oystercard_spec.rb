require 'oystercard.rb'

describe Oystercard do
  it { is_expected.to respond_to :balance }

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do
    it 'adds money to the oystercard balance' do
      oystercard = Oystercard.new(10)
      expect(oystercard.top_up(9)).to eq 19
    end

    it 'doesn\'t allow to top up beyond the limit' do
      oystercard = Oystercard.new(20)
      expect { oystercard.top_up(80) }.to raise_error("Exceeded #{Oystercard::MAX_LIMIT} limit")
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }

    it 'returns false when customer is not travelling' do
    oystercard = Oystercard.new(1)
    expect(oystercard.in_journey?).to eq false

    end
  end

  describe '#touch_in' do
    let (:entry_station) {double :station}

    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it 'checks if card stores an entry station' do
      oystercard = Oystercard.new(2)
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station

    end
  end

  describe '#touch_out' do
    let (:entry_station) {double :station}
    it { is_expected.to respond_to(:touch_out) }

    it 'returns false when customer touches out' do
      oystercard = Oystercard.new
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end

    it 'deducts correct amount when journey\'s complete' do
    oystercard = Oystercard.new(20)
    expect{oystercard.touch_out}.to change{oystercard.balance}.by(-1)
  end

    it 'resets the entry station upon touching out' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out
    expect(subject.entry_station).to eq nil
  end
end

  describe '#min_amount' do
    it { is_expected.to respond_to(:min_amount)}

    it 'raises an error if the balance is less than £1' do
      oystercard = Oystercard.new
      expect { oystercard.min_amount }.to raise_error("Please top up at least £#{Oystercard::MIN_FARE}")
    end
  end

end
