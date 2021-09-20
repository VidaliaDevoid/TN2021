 station1 = Station.new('BEGIN')
 station2 = Station.new('MIDDLE-1')
 station3 = Station.new('END')

 route = Route.new(station1, station3)
 route.add_new_station(station2)

 train1 = Train.new(514489, 'passenger', 5)
 train2 = Train.new(123457, 'cargo', 4)
 train3 = Train.new(678467, 'cargo', 10)

 train1.route=route
 train2.route=route
 train3.route=route

 train1.move_to('forward')
 train1.move_to('forward')

 train2.move_to('forward')
