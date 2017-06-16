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

  def touch_in(station, new_journey = Journey.new)
    raise "Please top up" if not_enough_money?
    deduct(journey.fare) if barrier_jumper?
    new_journey.start(station)
    previous_journeys.push(new_journey)
  end

  def touch_out(station)
    previous_journeys.push(Journey.new) unless journey.incomplete?
    journey.finish(station)
    deduct(journey.fare)
  end

  private
  def deduct(amount)
    @balance-= amount
  end

  def barrier_jumper?
    case
    when @previous_journeys.empty? then false
    when journey.incomplete? then true
    else false
    end
  end

  def too_much?(money)
    @balance + money > MAX_LIMIT
  end

  def not_enough_money?
    @balance < MIN_FARE
  end
end
