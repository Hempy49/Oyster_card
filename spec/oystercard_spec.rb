describe Oystercard do

require 'oystercard.rb'

describe Oystercard do
  it { is_expected.to respond_to :balance }

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do
    it 'adds money to the oystercard balance' do
      oystercard = Oystercard.new(10)
      expect(oystercard.top_up(9)).to eq 19
    end
  end

end