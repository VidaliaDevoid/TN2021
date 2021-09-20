class Train
  attr_accessor :route, :station
  attr_reader :carriage_count, :speed, :type, :number
  
  def initialize(number, type, carriage_count)
    @number = number
    @type = type #cargo passenger
    @carriage_count = carriage_count
    @speed = 0
  end

  def add_speed(speed)
    @speed += speed
  end

  def stop
    @speed = 0
  end

  def change_carriage_count(type)
    if @speed == 0
      case type
      when 'add'
        @count +=1
      when 'remove'
        @count -=1
      else
        puts 'Wrong change carriage count type.'
      end
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

  private
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

    def go_forward
      return unless next_station
      route.move_train(self, @current_station_index, 'forward')
      @current_station_index += 1
    end

    def go_back
      return unless prev_station
      route.move_train(self, @current_station_index, 'back')
      @current_station_index -= 1
    end
end
