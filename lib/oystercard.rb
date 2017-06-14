# lib/oystercard.rb
class Oystercard
  attr_accessor :balance, :money, :entry_station
  attr_reader :exit_station, :journey, :journeys
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MIN_FARE = 1

   def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station
    @journeys = []
    @exit_station
    @journey = {}
  end

  def top_up(money)
    raise "Exceeded #{MAX_LIMIT} limit" if @balance + money >= MAX_LIMIT
    @balance += money
  end

  def in_journey?
    entry_station != nil
  end

  def touch_in(entry_station)
    min_amount
    @entry_station = entry_station
    @journey = Hash[entry_station, entry_station]
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @exit_station = exit_station
    @journey.each {|k,v| @journey[k] = exit_station }
    @journeys << @journey
    @entry_station = nil 
  end

  def min_amount
    fail "Please top up at least £#{MIN_FARE}" if @balance < 1
  end

  private

  def deduct(min_fare)
    @balance -= MIN_FARE
  end

end
