require_relative 'station'

class Journey
  attr_reader :entry_station, :exit_station

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station  = nil
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def incomplete?
    entry_station.nil? || exit_station.nil?
  end

  def fare
    incomplete? ? PENALTY_FARE : MIN_FARE
  end
end
