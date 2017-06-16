require_relative 'Journey'

class Oystercard

  attr_reader :balance, :previous_journeys

  MAX_LIMIT = 100
  MIN_FARE = 1

  def initialize(balance = 0)
    @balance           = balance
    @previous_journeys = []
  end

  def topup(amount)
    raise "You have reached your maximum balance limit" if @balance + amount > MAX_LIMIT
    @balance += amount
  end

  def in_journey?
    !!journey #send message to journey class to check
  end

  def touch_in(station)
    raise "Please top up" if @balance < MIN_FARE
    previous_journeys.push Journey.new(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    previous_journeys.last.record_end(station)
  end

  private
  def deduct(amount)
    @balance-= amount
  end
end
