require_relative 'Station'

class Journey
  attr_reader :entry_station, :exit_station

  def initialize(station)
    @entry_station = station
    @exit_station = nil
  end

  def record_journey(entry_station, exit_station)
    { entry: @entry_station, exit: exit_station }
  end

  def record_end(station)
    @exit_station = station
  end

end
