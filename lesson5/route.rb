require_relative 'instance_counter'

class Route
  attr_reader :stations
  
  def initialize(begin_station, end_station)
    register_instance
    @stations = [begin_station, end_station]
  end

  def add_new_station(station)
    stations[1,0] = station
  end

  def add_train(train)
    stations.first.add_train(train)
  end

  def move_train(train, station_index, type)
    stations[station_index].remove_train(train)
    
    case type
    when 'forward'
      stations[station_index + 1].add_train(train)
    when 'back'
      stations[station_index - 1].add_train(train)
    else
      puts 'Wrong move type.'
    end
  end

  def remove_station(station)
    unless (station == stations.first) || (station == stations.last)
      if station.trains.count == 0
        stations.delete(station)
      else 
        puts "You can't delete this station, it has #{station.trains.count} trains on it."
      end
    else
      puts "You can't remove station: #{station.name}."
    end
  end

  def stations_list
    stations.each.with_index do |station, index|
      puts "#{index + 1}) #{station.name}"
    end
  end

  private
  # we can change stations only by public methods.
  attr_writer :stations

end
