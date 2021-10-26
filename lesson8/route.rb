# frozen_string_literal: true

require_relative 'instance_counter'

class Route
  attr_reader :stations

  include InstanceCounter

  def initialize(begin_station, end_station)
    register_instance
    @stations = [begin_station, end_station]
    validate!
  end

  def add_new_station(station)
    stations[1, 0] = station
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
      raise 'Wrong move type.'
    end
  end

  def remove_station(station)
    raise "You can't remove station: #{station.name}." if (station == stations.first) || (station == stations.last)
    unless station.trains.count.zero?
      raise "You can't delete this station, it has #{station.trains.count} trains on it."
    end

    stations.delete(station)
  end

  def stations_list
    stations.each.with_index do |station, index|
      puts "#{index + 1}) #{station.name}"
    end
  end

  private

  # we can change stations only by public methods.
  attr_writer :stations

  protected

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def validate!
    raise ArgumentError, 'Begin or end station cant be nil.' if stations.first.nil? || stations.last.nil?
  end
end
