require_relative 'Station'

class Journey
  attr_reader :entry_station

  def initialize(station)
    @entry_station = station
  end

  def record_journey(entry_station, exit_station)
    { entry: @entry_station, exit: exit_station }
  end

end
