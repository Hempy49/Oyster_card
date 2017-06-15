require_relative 'Journey'

class Oystercard

  attr_reader :balance, :entry_station, :previous_journeys, :journey

  MAX_LIMIT = 100
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance           = balance
    # @entry_station     = nil
    @previous_journeys = []
    @journey
  end

  def topup(amount)
    raise "You have reached your maximum balance limit" if @balance + amount > MAX_LIMIT
    @balance += amount
  end

  def in_journey?
    !!journey
  end

  def touch_in(station)
    raise "Please top up" if @balance < MIN_FARE
    # @entry_station = station
    @journey = Journey.new(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    var = journey.record_journey(@entry_station, station)
    @previous_journeys.push var
    @journey = nil
  end

  private
  def deduct(amount)
    @balance-= amount
  end

  # def record_journey(entry_station, exit_station)
  #   journey = { entry: entry_station, exit: exit_station }
  #   @previous_journeys.push journey
  # end
end
