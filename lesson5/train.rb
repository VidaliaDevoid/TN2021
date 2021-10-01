require_relative 'producer'
require_relative 'instance_counter'

class Train
  include Producer
  include InstanceCounter
  attr_accessor :route, :station
  attr_reader :speed, :number, :type, :carriages

  @@trains = []

  def self.find(number)
    @@trains.find{ |s| s.number == number}
  end
  
  def initialize(number)
    @number = number
    @speed = 0
    @carriages = []
    register_instance
    @@trains << self
  end

  def add_speed(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def add_carriage(carriage)
    if @speed == 0
      @carriages << carriage if carriage.type == @type
    else
      puts 'Stop train before change carriage count.'
    end
  end

  def remove_carriage(carriage)
    if @speed == 0
      @carriages.delete(carriage) if carriage.type == @type
    else
      puts 'Stop train before change carriage count.'
    end
  end

  def route=(route)
    @route = route
    @current_station_index = 0
    @route.add_train(self)
  end

  def station
    @route.stations[@current_station_index]
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
    if @current_station_index > 0
      station_index = @current_station_index - 1 
      @route.stations[station_index]
    end
  end

  def next_station
    if @current_station_index < @route.stations.count
      station_index = @current_station_index + 1 
      @route.stations[station_index]
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
