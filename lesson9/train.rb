# frozen_string_literal: true

require_relative 'producer'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Producer
  include InstanceCounter
  include Validation
  
  attr_writer :station
  attr_reader :speed, :number, :type, :carriages

  TYPES = %w[cargo passenger].freeze
  NUMBER = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  validate :number, :format, NUMBER

  @@trains = []

  def self.find(number)
    @@trains.find { |s| s.number == number }
  end

  def initialize(number)
    @number = number
    @speed = 0
    @carriages = []
    register_instance
    @@trains << self
    validate!
  end

  # def valid?
  #   validate!
  #   true
  # rescue StandardError
  #   false
  # end

  # def validate!
  #   raise 'Check number of train.' unless number =~ NUMBER
  # end

  def add_speed(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    carriages << carriage if carriage.type == type
    raise 'Stop train before change carriage count.' unless speed.zero?
  end

  def remove_carriage(carriage)
    carriages.delete(carriage) if carriage.type == type
    raise 'Stop train before change carriage count.' unless speed.zero?
  end

  def route=(route)
    @route = route
    @current_station_index = 0
    route.add_train(self)
  end

  def station
    route.stations[@current_station_index]
  end

  def move_to(type)
    case type
    when 'forward'
      go_forward
    when 'back'
      go_back
    else
      'Wrong train move type.'
    end
  end

  def prev_station
    return unless current_station_index.positive?

    station_index = current_station_index - 1
    route.stations[station_index]
  end

  def next_station
    return unless current_station_index.positive?

    station_index = current_station_index + 1
    route.stations[station_index]
  end

  def each_carriage(&block)
    carriages.each(&block)
  end

  def list_carriages
    each_carriage do |c|
      if c.type == 'cargo'
        puts "##{c.number} #{c.type} -- free volume: #{c.free_place} #{c.class::UNITS}, placed colume: #{c.used_place}."
      else
        puts "##{c.number} #{c.type} -- free seats: #{c.free_place} #{c.class::UNITS}, placed seats: #{c.used_place}."
      end
    end
  end

  private

  # `speed` can change only with `add_speed` or `stop` methods.
  # same with carriages.
  attr_writer :speed, :carriages

  # used in public `move_to` method.
  def go_forward
    return unless next_station

    route.move_train(self, @current_station_index, 'forward')
    @current_station_index += 1
  end

  # used in public `move_to` method.
  def go_back
    return unless prev_station

    route.move_train(self, @current_station_index, 'back')
    @current_station_index -= 1
  end
end
