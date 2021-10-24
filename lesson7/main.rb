require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'route'
require_relative 'station'

class Main
  attr_reader :stations, :trains, :routes

  def initialize
      @stations = []
      @trains = []
      @routes = []
  end

  def select_point
    command_list

    loop do
      puts "================="
      print "Select command: "
      point = gets.strip

      case point
      when '0' then break
      when '1' then create_station
      when '2' then create_train
      when '3' then create_route
      when '4' then change_route
      when '5' then set_route_to_train
      when '6' then join_carriage
      when '7' then delete_carriage
      when '8' then move_forward
      when '9' then move_back
      when '10' then stations_list
      when '11' then trains_list
      when '12' then trains_list_by_station
      when '13' then routes_list
      when '14' then list_carriages
      when '15' then take_a_seat
      when '16' then place_volume
      else puts 'Wrong number point.'
      end
    end
  end

  private

  attr_writer :stations, :trains, :routes

  def command_list
    menu = [
      '1) Create station',
      '2) Create train',
      '3) Create route',
      '4) Change route',
      '5) Add route to train',
      '6) Add carriage to train',
      '7) Remove carriage to train',
      '8) Move forward train on his route',
      '9) Move back train on his route',
      '10) Show stations list',
      '11) Show trains list',
      '12) Show trains on the stations',
      '13) Show route list',
      '14) Show carriages list',
      '15) Take a seat in passenger train',
      '16) Place volume in cargo train',
      '0) Exit'
    ]
    menu.each { |point| puts point }
  end

  def create_station
    print "Station name: "
    name = gets.strip

    stations.push(Station.new(name))
    print "You created station: #{stations.last.name}\n"
    stations.last
  end

  def create_train
    begin
      print "Train number: "
      number = gets.strip

      if Train.find(number)
        raise 'Train with this number already exist. Try again.'
        return
      end
  
      print "Select train type - cargo or passenger: "
      type = gets.strip

      case type
      when 'cargo'
        trains.push(CargoTrain.new(number))
      when 'passenger'
        trains.push(PassengerTrain.new(number))
      else
        raise 'Wrong train type. Try again.'
      end
    rescue => e
      puts e.message
      retry
    end

    puts "Last created train #{trains.last.number}."
    trains.last
  end

  def stations_list
    print "Stations:\n"
    stations.each.with_index do |station, index|
      puts "#{index+1}) #{station.name}"
    end
    nil
  end

  def trains_list
    trains.each_with_index do |train, index|
      puts "#{index+1}) #{train}"
    end
  end

  def trains_list_by_station
    station = select_station
    puts "Station #{station} include trains:"
    station.list_trains
  end

  def create_route
    if stations.size >= 2
      stations_list
      print "First station index: "
      first_index = gets.to_i - 1

      print "Last station index: "
      last_index = gets.to_i - 1

      routes.push(Route.new(stations[first_index], stations[last_index]))
      routes.last
    else 
      puts "You doesn't have at least two stations."
    end
  end

  def select_route
    routes_list
    print "Select route index: "
    routes[gets.strip.to_i-1]
  end

  def change_route
    route = select_route

    puts "1 - add, 2 - remove"
    select_point = gets.strip.to_i

    if select_point == 1
      route.add_new_station(select_station)
    else
      remove_station_from_route(route)
    end
  end

  def routes_list
    print "All routes:\n"
    routes.each.with_index do |route, index|
      puts "#{index+1}) BEGIN: #{route.stations.first.name} END: #{route.stations.last.name}"
    end
  end

  def remove_station_from_route(route)
    if route.stations.count <= 2
      raise "You can't remove any station."
    else
      puts "Which one to remove?"
      stations_list
      route.remove_station(route.stations[gets.strip.to_i-1])
    end
  end

  def select_station
    stations.each_with_index do |station, index|
      puts "#{index+1}) Station name: #{station.name}"
    end
    print "Select number station: "
    stations[gets.strip.to_i-1]
  end

  def select_train
    trains_list
    print "Select index train: "
    trains[gets.strip.to_i-1]
  end

  def select_carriage
    train = select_train 
    print "Select number carriage: "
    number = gets.strip.to_i
    train.carriages.select{|c| c.number == number}.first
  end

  def set_route_to_train
    if trains.empty? || routes.empty?
      puts "You have no routes or trains."
    else
      select_train.route = select_route
    end
  end

  def join_carriage
    train = select_train
    case train.type
    when "cargo" then 
      print "Cargo carriage volume: "
      volume = gets.strip.to_f
      train.add_carriage(CargoCarriage.new(volume))
    when "passenger" then 
      print "Passenger carriage places: "
      places = gets.strip.to_i
      train.add_carriage(PassengerCarriage.new(places))
    end
  end

  def delete_carriage
    train = select_train
    if train.carriages.empty?
      puts "Train has no carriages."
    else
      train.remove_carriage(train.carriages.last)
    end
  end

  def list_carriages
    train = select_train
    train.list_carriages
  end

  def take_a_seat
    carriage = select_carriage
    begin
      if carriage.type == 'passenger'
        carriage.take_seat
      else
        raise 'Wrong carriage type. Try again.'
      end
    rescue => e
      puts e.message
      retry 
    end
  end

  def place_volume
    carriage = select_carriage
    begin
      print "Volume to place: "
      volume = gets.strip.to_i
      if carriage.type == 'cargo'
        carriage.place_volume(volume)
      else
        raise 'Wrong carriage type. Try again.'
      end
    rescue => e
      puts e.message
      retry 
    end
  end

  def move_forward
    select_train.move_to('forward')
  end

  def move_back
    select_train.move_to('back')
  end
end

Main.new.select_point
