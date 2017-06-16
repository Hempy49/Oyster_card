require_relative 'journey'

class Oystercard

  attr_reader :balance, :previous_journeys

  MAX_LIMIT = 100
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance           = balance
    @previous_journeys = []
  end

  def topup(amount)
    raise "You have reached your maximum balance limit" if too_much? amount
    @balance += amount
  end

  def journey
    previous_journeys.last
  end

  def in_journey?
    journey.exit_station == nil
  end

  def touch_in(station, journey = Journey.new)
    raise "Please top up" if not_enough_money?
    journey.start(station)
    previous_journeys.push(journey)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    journey.finish(station)
  end

  private
  def deduct(amount)
    @balance-= amount
  end

  def too_much?(money)
    @balance + money > MAX_LIMIT
  end

  def not_enough_money?
    @balance < MIN_FARE
  end
end
